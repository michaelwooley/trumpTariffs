"""This file explores the conversion from PUMA to counties.

There are multiple cases for each PUMA/County:

- 1 -> 1. One PUMA maps to one county (goldilocks)
- 1 -> M. One PUMA maps to many counties (as in rural areas)
- M -> 1. Multiple PUMAs map to one county (as in urban area)
- M -> M. Multiple PUMAs map to multiple counties (See Denver)

The basic takeaway from this is that - for the sake of time - we
should just use the following process:

- For each county:
  - Find all PUMAs that have tracts in the county.
  - Pool all of the stats from those PUMAs to make "county-level" statistics.

This should serve as a passable solution for cases where we're not concerned
with population levels.

Attributes:
    checked (list): List of counties checked
    cw (TYPE): Frame indexed by PUMA
    cw2 (TYPE): Frame indexed by county
    cwd (TYPE): Crosswalk of pumas -> counties
    cwd2 (TYPE): Crosswalk county -> PUMA
    ii (int): Description
"""
import pandas as pd
import zipfile

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

cw.set_index('puma_id', inplace=True)

cwd = {pid: cw.at[pid, 'county_id'] for pid in cw.index.unique()}
cwd = {k: [v] if isinstance(v, str) else list(v) for k, v in cwd.items()}

cw2 = cw.reset_index().set_index('county_id')

cwd2 = {pid: cw2.at[pid, 'puma_id'] for pid in cw2.index.unique()}
cwd2 = {k: [v] if isinstance(v, str) else list(v) for k, v in cwd2.items()}

print(
  'Counties in multiple PUMAs in which other counties with multiple PUMAs exist.'
)
ii = 0
checked = []
for k, v in cwd2.items():

  if len(v) > 1:
    for puma in v:
      if len(cwd[puma]) > 1:

        for oc in cwd[puma]:
          if (len(cwd2[oc]) > 1 and oc != k) and (oc not in checked):
            ii += 1
            print(ii, k, oc, puma)

  checked.append(k)

with zipfile.ZipFile('../data/raw/BP_2015_00A1.zip', 'r') as archive:
  bp = pd.read_csv(
    archive.open('BP_2015_00A1_with_ann.csv'),
    skiprows=2,
    names=[
      'id', 'id2', 'county_name', 'geo_type', 'state', 'county',
      'fips_combined_stat_area_code', 'metro', 'metro2', 'naics2',
      'naics2_name', 'year', 'year_meaning', 'est_n', 'emp', 'emp_noise',
      'payroll_q1', 'payroll_q1_noise', 'payroll', 'payroll_noise'
    ],
    encoding="ISO-8859-1"
  )
bp['county_id'] = bp.apply(
  lambda d: '{:02d}{:03d}'.format(d['state'], d['county']), axis=1
)
