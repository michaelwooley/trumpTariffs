import pandas as pd
import numpy as np
from src.IpumsExtract import IpumsExtract

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

df = ie.read_sql(script)

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

# Get share of county that employed in each industry
for name in ['emp_steel', 'emp_alum', 'emp_tariff']:
  emp[name + '_cty_emp_sh'] = 100 * emp[name] / emp['emp']

# Merge on Puma name
puma_names = pd.read_fwf(
  '../../data/raw/2010_PUMA_Names.csv',
  delimiter=',',
  skiprows=1,
  names=['state', 'puma', 'puma_name']
)

state_names = pd.read_fwf(
  '../../data/raw/statefips_labels.txt',
  delimiter='|',
  skiprows=1,
  names=['state', 'state_abbrev', 'state_name', 'safasfas']
)

emp = emp.merge(puma_names, on=['state', 'puma'], how='left')
emp = emp.merge(
  state_names[['state', 'state_abbrev']], on=['state'], how='left'
)

emp['id'] = emp.apply(
  lambda d: '{:02d}{:05d}'.format(d['state'], d['puma']), axis=1
)

emp.to_csv('../data/int/tariff_ind_emp.csv')
