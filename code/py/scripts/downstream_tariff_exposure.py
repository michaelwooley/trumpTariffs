"""Summary
"""
import pickle, zipfile
import pandas as pd
import numpy as np
from tabulate import tabulate
from typing import Tuple, Dict, List
import statsmodels.formula.api as sm

from src.IpumsExtract import IpumsExtract


class DownstreamTariffExposure(object):
  """Creates statistics to discuss downstream worker exposure to 
  Steel and Aluminum tariffs.

  Attributes:
      io_ind (TYPE): Description
  """

  def __init__(self):
    """Init/Main Script
    """

    # Retrieve IO Industries
    self.get_io_ind()

    # Get the names of the counties
    self.get_county_names()

  def get_io_ind(self, inplace: bool = True) -> pd.DataFrame:
    """Retrieves and formats industries for IO tables.

    Returns:
        pd.DataFrame: frame with columns:
          naics2 (str) - 2-digit NAICS code
          naics3 (str) - 3-digit NAICS code
          naics6 (str) - 6-digit/"Detailed" NAICS code
          *_name (str) - Descriptions of each code
    """
    io_ind = pd.read_excel(
      '../data/raw/CxI_DR_1997-2016_Summary.xlsx',
      sheetname='NAICS codes',
      names=['naics2', 'naics3', 'naics6', 'naics6_name', 'notes', 'related'],
      skiprows=3,
      skipfooter=6
    )

    io_ind = io_ind[['naics2', 'naics3', 'naics6', 'naics6_name']]

    for vv in ['naics2', 'naics3', 'naics6']:
      io_ind[vv] = io_ind[vv].apply(str)

    io_ind['naics2_name'] = io_ind.apply(
      lambda d: d['naics3'] if d['naics2'] != 'nan' else np.nan, axis=1
    )
    io_ind['naics3_name'] = io_ind.apply(
      lambda d: d['naics6'] if d['naics3'] != 'nan' else np.nan, axis=1
    )

    io_ind['naics3'] = io_ind.apply(
      lambda d: d['naics3'] if d['naics2'] == 'nan' else np.nan, axis=1
    )
    io_ind['naics6'] = io_ind.apply(
      lambda d: d['naics6'] if d['naics3'] == 'nan' else np.nan, axis=1
    )

    for vv in ['naics2', 'naics3', 'naics6']:
      io_ind[vv] = io_ind[vv].apply(lambda d: d if (d != 'nan') else np.nan)
      io_ind[vv + '_name'] = io_ind[vv + '_name'].apply(
        lambda d: d if (d != 'nan') else np.nan
      )

      if vv != 'naics6':
        io_ind[vv] = io_ind[vv].fillna(method='ffill')
        io_ind[vv + '_name'] = io_ind[vv + '_name'].fillna(method='ffill')

    io_ind.dropna(how='any', inplace=True)
    io_ind = io_ind[[
      'naics2', 'naics3', 'naics6', 'naics2_name', 'naics3_name', 'naics6_name'
    ]]

    if inplace:
      self.io_ind = io_ind

    return io_ind

  def get_county_names(self, inplace: bool = True):
    cty = pd.read_csv(
      '../data/raw/national_county.txt',
      names=['state_name', 'state', 'county', 'county_name', 'type']
    )

    cty['county_id'] = cty.apply(
      lambda d: '{:02d}{:03d}'.format(d['state'], d['county']), axis=1
    )

    cty['county_state'] = cty.apply(
      lambda d: '{}, {}'.format(d['county_name'], d['state_name']), axis=1
    )

    if inplace:
      self.county_names = cty

    return cty

  def get_io_data(self, inplace: bool = True) -> pd.DataFrame:
    """Retrieve data for IO tables.

    Returns:
        pd.DataFrame: The direct requirements matrix
    """
    # The Direct Requirements Matrix
    DR = pd.read_pickle('../data/int/DR_io_table.pkl')

    if inplace:
      self.DR = DR

    return DR

  def get_acs_data(self, inplace: bool = True) -> pd.DataFrame:
    """Get ACS data from SQL.

    Returns:
        pd.DataFrame: Estimates of workers by industry in each PUMA from the 5-year ACS
    """
    # Employment across PUMAs in ACS.
    # Initiate IpumsExtract Object
    ie = IpumsExtract(
      '../data/raw/usa_00022.dat.gz',
      '../data/raw/usa_00022.do',
      db_filename='../data/int/acs_2016.db'
    )

    # Get the number of workers in each county-industry
    script = """
    SELECT
      SUM(perwt) * 0.01 as count,
      indnaics as ind,
      puma,
      statefip as state
    FROM
      main
    GROUP BY
      indnaics,
      puma,
      statefip
      ;
    """

    acs = ie.read_sql(script)

    if inplace:
      self.acs = acs

    return acs

  def what_industries_are_most_exposed(
    self,
    inds: [list],
    inputsOnly: bool = True,
    mxR: int = 10,
    toKeep: list = [1, 2, 5, 10, 'Infinite']
  ) -> pd.DataFrame:
    """Finds exposure of each industry in IO table to the given set of industries.

    Args:
        inds (list): Set of industry codes to compute requirements from. (i.e. if include steel and aluminum industries, will get requirements of all industries for steel and aluminum.)
        inputsOny (bool, optional): If true computes exposure in terms of costs for the industry. That is, "total requirements" will not include the final unit of output to be produced. The main effect of setting this option equal to `True` is that the industries in `inds` will not appear to have the greatest requirements. This makes sense if you're trying to think about how much an industry must pay in input costs. 
        mxR (int, optional): Description
        toKeep (list, optional): Description

    No Longer Returned:
        pd.DataFrame: Description
    """

    if not hasattr(self, 'DR'):
      self.get_io_data()

    ie = pd.DataFrame(index=self.DR.index)

    # Useful identity matrix
    II = np.eye(self.DR.shape[0])

    # Find requirements in finite order.

    rmi = pd.DataFrame(II, index=self.DR.index, columns=self.DR.columns)

    rm = pd.DataFrame(
      np.zeros_like(self.DR), index=self.DR.index, columns=self.DR.columns
    ) if inputsOnly else rmi.copy()
    for ii in range(1, mxR + 1):

      # Compute requirements at order ii
      rmi = rmi.dot(self.DR)
      rm = rm + rmi

      # Save requirements for selected industries
      ie[ii] = rm.loc[inds].sum()

    # Infinite-Order Requirements
    TR = pd.DataFrame(
      np.linalg.solve(II - self.DR, II),
      index=self.DR.index,
      columns=self.DR.columns
    )

    ie['Infinite'] = TR.loc[inds].sum()

    ie = ie[toKeep]

    return ie

  def convert_io_result_to_acs_result(self, ior: [pd.DataFrame, pd.Series]
                                      ) -> [pd.DataFrame, pd.Series]:
    """Convert a result stated in terms of IO industries to a result stated
      in terms of ACS industries.

    Args:
        ior (pd.DataFrame, pd.Series): Frame or series with IO industries (6-digit) as the index.

    Returns:
        pd.DataFrame, pd.Series: Frame or series with results from ior converted to have ACS industry codes (and industry code as index). In cases where more than one IO industry code is applicable, takes the median of the values from the applicable industries in `ior`
    """
    if not hasattr(self, 'acs_io_cw'):
      self.acs_io_cw = pd.read_pickle('../data/int/acs_to_io_crosswalk.pkl')[[
        'ind', 'io_ind'
      ]].set_index('ind').to_dict()['io_ind']
    cw = self.acs_io_cw

    if isinstance(ior, pd.Series):
      out = pd.Series(index=cw.keys(), name=ior.name)
    else:
      out = pd.DataFrame(index=cw.keys(), columns=ior.columns)

    for k, v in cw.items():
      out.at[k] = ior.loc[v].median()

    return out

  def get_wgt_mean(
    self, df: pd.DataFrame, wgt: str, columns: [list, None] = None
  ):

    if columns is None:
      columns = [
        col for col in df.columns
        if col != wgt and isinstance(df[col].values[0], (float, int))
      ]

    return pd.Series(
      [(df[col] * df[wgt] / df[wgt].sum()).sum() for col in columns],
      index=columns
    )

  def what_pumas_are_exposed_downstream(self):

    if not hasattr(self, 'acs'):
      self.get_acs_data()

    ie = self.what_industries_are_most_exposed(['331110', '33131A'])

    iec = self.convert_io_result_to_acs_result(ie)

    iec.rename(
      columns={col: 'tariff_exp_' + str(col)
               for col in iec.columns},
      inplace=True
    )
    iec.index.name = 'ind'
    iec.reset_index(inplace=True)

    acs = self.acs.merge(iec, on='ind')

    vars_to_agg = [col for col in iec.columns if col != 'ind']
    wm = lambda g: self.get_wgt_mean(g, wgt='count', columns=vars_to_agg)
    psg = acs.groupby(['puma', 'state']).apply(wm)

    return psg

  def what_pumas_have_steel_and_alum(self):

    if not hasattr(self, 'acs'):
      self.get_acs_data()
    df = self.acs.copy()

    # Get total number of workers: overall, steel, aluminum
    emp_inds = {
      'emp': df['ind'].unique(),
      'emp_steel': ['331M'],
      'emp_alum': ['3313'],
      'emp_tariff': ['331M', '3313']
    }

    emp = []

    for name, codes in emp_inds.items():
      dd = df.loc[df['ind'].isin(codes)].groupby(
        ['state', 'puma']
      )['count'].sum().to_frame('value')
      dd['variable'] = name
      emp.append(dd)

    emp = pd.concat(emp).reset_index()
    emp = emp.pivot_table(
      index=['state', 'puma'], columns='variable', values='value'
    )
    emp.reset_index(inplace=True)
    emp = emp.fillna(0)

    for vv in ['emp_alum', 'emp_steel', 'emp_tariff']:
      emp[vv] = 100 * emp[vv] / emp['emp']

    emp.drop('emp', axis=1, inplace=True)

    return emp

  def get_county_to_puma_crosswalk(self, inplace: bool = True) -> dict:

    cw = pd.read_csv(
      '../data/raw/2010_Census_Tract_to_2010_PUMA.txt',
      skiprows=1,
      names=['state', 'county', 'tract', 'puma']
    )[['state', 'county', 'puma']]

    cw = cw.loc[~cw.duplicated()].reset_index(drop=True)

    cw['county_id'] = cw.apply(
      lambda d: '{:02d}{:03d}'.format(d['state'], d['county']), axis=1
    )
    cw['puma_id'] = cw.apply(
      lambda d: '{:02d}{:05d}'.format(d['state'], d['puma']), axis=1
    )

    cw.set_index('county_id', inplace=True)

    cwd = {pid: cw.at[pid, 'puma_id'] for pid in cw.index.unique()}
    cwd = {k: [v] if isinstance(v, str) else list(v) for k, v in cwd.items()}

    if inplace:
      self.county_to_puma_cw = cwd

    return cwd

  def puma_to_county_conversion(self, df: pd.DataFrame) -> pd.DataFrame:
    """Converts results in terms of PUMAs as results in terms of counties.

    NOTE: This is a very rough way of doing this. For more discussion see the script '../scripts/puma_to_county_crosswalk_exploration.py'

    Args:
        df (pd.DataFrame): A frame with numeric values and a 'puma_id' index that is a 7-digit string where the first 2 digits are the state fips code while the latter five are the state-dependent PUMA identifier.

    Returns:
        pd.DataFrame: A frame with numeric values and a 'county_id' index that is a 5-digit string where the first 2 digits are the state fips code while the latter three are the state-dependent County fips code. This frame is compiled by finding all PUMAs that overlap with a given county. This is an inexact procedure. Please see the previously-mentioned script for more details.
    """
    if not hasattr(self, 'puma_to_county_cw'):
      self.get_county_to_puma_crosswalk()
    cw = self.county_to_puma_cw

    out = pd.DataFrame(index=cw.keys(), columns=df.columns)
    for k, v in cw.items():

      # KeyError will be passed for territories (e.g. USVI) that are not
      # in data.
      try:
        out.at[k] = df.loc[v].mean()
      except KeyError as e:
        pass

    out.dropna(how='all', inplace=True)
    out = out.apply(lambda d: d.apply(float))
    return out

  def what_counties_are_exposed_downstream(self):

    ped = self.what_pumas_are_exposed_downstream()

    ped.reset_index(inplace=True)
    ped['puma_id'] = ped.apply(
      lambda d: '{:02d}{:05d}'.format(int(d['state']), int(d['puma'])), axis=1
    )

    ped.drop(['puma', 'state'], axis=1, inplace=True)
    ped.set_index('puma_id', inplace=True)

    return self.puma_to_county_conversion(ped)

  def what_counties_have_steel_and_alum(self):

    ped = self.what_pumas_have_steel_and_alum()

    ped.reset_index(drop=True, inplace=True)
    ped['puma_id'] = ped.apply(
      lambda d: '{:02d}{:05d}'.format(int(d['state']), int(d['puma'])), axis=1
    )

    ped.drop(['puma', 'state'], axis=1, inplace=True)
    ped.set_index('puma_id', inplace=True)

    return self.puma_to_county_conversion(ped)


def main(outfile: str = '../data/int/county_emp_tariffs_data.csv'):

  splitter = '\n' + '%~' * 45 + '\n'

  dte = DownstreamTariffExposure()

  # Get the IO data
  dte.get_io_data()

  # INDUSTRY EXPOSURE (Steel and aluminum together)
  # Most exposed industries
  ie = dte.what_industries_are_most_exposed(['331110', '33131A'])

  me = ie.sort_values(5, ascending=False).head()
  ni = dte.io_ind.loc[dte.io_ind['naics6'].isin(me.index)]
  ni.set_index('naics6', inplace=True)
  me.index = ni.loc[me.index, 'naics6_name']
  me.index.name = 'Industry'

  print(splitter)
  print('Industry Exposure to the Steel and Aluminum Industries')
  print(tabulate(me.round(3), headers=me.columns, tablefmt="pipe"))

  # Average Increase from 1 to large-order
  ie = dte.what_industries_are_most_exposed(
    ['331110', '33131A'], mxR=25, toKeep=[1, 25]
  )
  avgInc = ((ie[25] - ie[1]) / ie[1]).describe()

  print(splitter)
  print(
    'Increase in industry exposure from higher-order (1->25th) interactions'
  )
  print(avgInc)

  # Exposure BY County
  cme = dte.what_counties_are_exposed_downstream()
  me = cme.sort_values('tariff_exp_1', ascending=False).head(5)
  ni = dte.county_names.loc[dte.county_names['county_id'].isin(me.index)]
  ni.set_index('county_id', inplace=True)
  me.index = ni.loc[me.index, 'county_state']
  me.index.name = 'County'
  me.columns = [col.split('_')[-1] for col in me.columns]

  print(splitter)
  print('Counties most exposed to Steel and Aluminum in Inputs')
  print(tabulate(me.round(3), headers=me.columns, tablefmt="pipe"))
  print(splitter)

  # Counties with steel and aluminum
  emp = dte.what_counties_have_steel_and_alum()
  me = emp.sort_values('emp_tariff', ascending=False).head(5).copy()
  ni = dte.county_names.loc[dte.county_names['county_id'].isin(me.index)]
  ni.set_index('county_id', inplace=True)
  me.index = ni.loc[me.index, 'county_state']
  me.index.name = 'County'
  me.columns = [col.split('_')[-1] for col in me.columns]

  print(splitter)
  print(
    'Share of County Employment, by Industry (Steel, Aluminum, and  Combined)'
  )
  print(tabulate(me.round(3), headers=me.columns, tablefmt="pipe"))
  print(splitter)

  dte.county_names.set_index('county_id', inplace=True)
  emp = emp.merge(cme, left_index=True, right_index=True, how='outer')
  emp['state_name'] = dte.county_names['state_name']
  emp['county_state'] = dte.county_names['county_state']
  emp.index.name = 'id'
  emp.to_csv(outfile)
  print(splitter)
  print('Saved county employment data to `{}`'.format(outfile))
  print(splitter)
  return dte


if __name__ == '__main__':
  dte = main()
