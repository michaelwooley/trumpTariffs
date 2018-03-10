"""Makes an NAICS Crosswalk and labels

Attributes:
    df (TYPE): Description
"""
import pandas as pd
import pickle, re

NAICS_FILE = '../data/raw/naics_codes_ipums.xlsx'
NAICS_SHEET = 'data'


def aps_naics_labels(
  outfile: str = '../data/int/aps_naics_labels.pkl'
) -> dict:
  def parse_keys(k):
    if isinstance(k, str):
      return re.match('^([0-9A-Z]+)(.*)', k).group(1)
    else:
      return str(k)

  df = pd.read_excel(NAICS_FILE, sheetname=NAICS_SHEET)
  df = df[['INDNAICS CODE\n(2003-onward ACS/PRCS)', 'INDUSTRY TITLE']]
  df.rename(
    columns={
      'INDNAICS CODE\n(2003-onward ACS/PRCS)': 'ind',
      'INDUSTRY TITLE': 'ind_name'
    },
    inplace=True
  )
  df.dropna(how='all', axis=0, inplace=True)
  df.fillna(method='ffill', inplace=True)
  df['ind'] = df['ind'].apply(parse_keys)
  df.set_index('ind', inplace=True)
  d = df['ind_name'].to_dict()

  with open(outfile, 'wb') as f:
    pickle.dump(d, f)

  return d


def aps_naics_crosswalk(
  outfile: str = '../data/int/aps_naics_crosswalk.pkl'
) -> dict:
  def parse_keys(k):
    if isinstance(k, str):
      return re.match('^([0-9A-Z]+)(.*)', k).group(1)
    else:
      return str(k)

  df = pd.read_excel(NAICS_FILE, sheetname=NAICS_SHEET)
  df.rename(
    columns={
      'INDNAICS CODE\n(2003-onward ACS/PRCS)': 'ind',
      '2012 NAICS EQUIVALENT': 'naics'
    },
    inplace=True
  )
  df = df[['ind', 'naics']]

  df.dropna(how='all', axis=0, inplace=True)
  df.fillna(method='ffill', inplace=True)
  df['ind'] = df['ind'].apply(parse_keys)
  df.set_index('ind', inplace=True)
  d = df['ind_name'].to_dict()

  with open(outfile, 'wb') as f:
    pickle.dump(d, f)

  return d


def format_county_name_file(outfile: str = '../data/int/county_names.pkl'):
  df = pd.read_csv(
    '../data/raw/fips_national_county.csv',
    header=None,
    names=['state', 'statefips', 'countyfips', 'county', 'unknown']
  )

  df.drop('unknown', axis=1, inplace=True)

  df['fips'] = df.apply(
    lambda d: '{:02d}{:03d}'.format(d['statefips'], d['countyfips']), axis=1
  )

  df['county-state'] = df.apply(
    lambda d: '{:s}, {:s}'.format(d['county'], d['state']), axis=1
  )

  df.to_pickle(outfile)
