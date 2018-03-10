"""Set up the input-output tables for use.
"""
import pandas as pd
import numpy as np

# Use table
ut = pd.read_excel(
  '../data/raw/IOUse_Before_Redefinitions_PRO_1997-2016_Summary.xlsx',
  sheetname='2016',
  skiprows=5,
  skipfooter=4,
  index_col=0,
  na_values='...'
)

ind_rows = ut.loc['IOCode']
ind_cols = ut['Commodities/Industries']

ut.drop('IOCode', axis=0, inplace=True)
ut.drop('Commodities/Industries', axis=1, inplace=True)

# Compute direct requirements of each industry
# This is the
