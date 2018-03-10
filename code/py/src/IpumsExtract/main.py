import re, sqlite3
import pandas as pd
import numpy as np
from warnings import warn
from tqdm import tqdm

from .recodes import getRecodes
from .utils import OrderedSet


class IpumsExtract(object):
  def __init__(
    self, filename: str, doFile: str, db_filename: [str, None] = None
  ):
    self.filename = filename
    self.doFile = doFile

    self.columns = []
    self.names = []
    self.labels = {}
    self.levels = {}
    self.dtypes = {}

    if db_filename is not None:
      self.db_filename = db_filename
      self.db = sqlite3.connect(db_filename)
      self.db_loaded = False
      self._get_db_table_names()
      if 'main' in self.db_tables:
        self.db_loaded = True

    self.parseDoFile()

  def parseDoFile(self) -> None:

    varDef = re.compile(
      r'(\s{2,2})(int|long|double|byte|float|str)(\s+)(\w+)(\s+)([0-9]+)(\-)([0-9]+)(\s+)(\/\/\/)(\n)'
    )
    labelDef = re.compile(
      r'(label var)(\s+)(\w+)(\s+)(`\")((?![\"]).*)(\"\')\n'
    )
    levelDef = re.compile(
      r'(label define)(\s)([\w\_]+)(\s)([\w\d]+)(\s)(\`\")((?![\"\']).*)(\"\')((\,\sadd)?)(\n)'
    )

    with open(self.doFile) as file:
      for line in file:

        # If it defines a variable
        f = varDef.match(line)
        if f is not None:
          self.names.append(f.group(4))
          self.dtypes[f.group(4)] = str
          self.columns.append((int(f.group(6)) - 1, int(f.group(8))))

        # If it defines a label
        f = labelDef.match(line)
        if f is not None:
          self.labels[f.group(3)] = f.group(6)

        # If it defines a level
        f = levelDef.match(line)
        if f is not None:
          var = f.group(3)[:-4]
          if var not in self.levels.keys():
            self.levels[var] = {}
          self.levels[var][int(f.group(5))] = f.group(8)
          self.dtypes[var] = str

    return None

  def convertToCategories(self, df: pd.DataFrame) -> pd.DataFrame:
    df.replace(self.levels, inplace=True)

    for col, lvl in self.levels.items():
      df[col] = df[col].astype('category')
      # df[col] = df[col].cat.set_categories(list(lvl.values()), ordered=False)

    return df

  def recodes(self, df: pd.DataFrame) -> pd.DataFrame:
    recodeDict = getRecodes()

    for var, rc in recodeDict.items():
      if var in df.columns:
        for rvar, lvl in rc.items():
          df[rvar] = df[var].copy()
          df[rvar] = df[rvar].replace(lvl)
          df[rvar] = df[rvar].astype('category')
          ulvl = OrderedSet(lvl.values())
          df[rvar] = df[rvar].cat.set_categories(ulvl, ordered=True)

          # Pop if the recode has the same name
          # as a pre-existing recode. This is done
          # for cases where only replacing 'NIU'/'Blank'/'Unknown'
          # responses
          self.levels.pop(rvar, None)

    return df

  def loadFull(
    self, toCategories: bool, recodes: bool, ageToInt: bool, **kwds
  ) -> pd.DataFrame:
    df = pd.read_fwf(
      self.filename, names=self.names, colspecs=self.columns, **kwds
    )

    if ageToInt:
      self.levels.pop('age', None)

    if recodes:
      df = self.recodes(df)

    if toCategories:
      df = self.convertToCategories(df)

    return df

  def loadChunk(
    self, toCategories: bool, recodes: bool, ageToInt: bool, **kwds
  ):
    dfc = pd.read_fwf(
      self.filename, names=self.names, colspecs=self.columns, **kwds
    )

    if ageToInt:
      self.levels.pop('age', None)

    def nextChunk():
      for chunk in dfc:
        if recodes:
          chunk = self.recodes(chunk)

        if toCategories:
          chunk = self.convertToCategories(chunk)

        yield chunk

    return nextChunk

  def to_sql(self, overwrite=True, chunksize=1000, verbose=True, **kwds):

    if overwrite:
      self.db.execute('DROP TABLE IF EXISTS main;')

    chunks = pd.read_fwf(
      self.filename,
      names=self.names,
      colspecs=self.columns,
      chunksize=chunksize,
      **kwds
    )

    if verbose:
      chunks = tqdm(chunks)

    for chunk in chunks:
      chunk.to_sql('main', self.db, if_exists='append')

    self.db_loaded = True
    return None

  def _get_db_table_names(self) -> list:
    """Get the names of the tables in the database.

    Returns:
        list: Names of tables (in alpha order).
    """
    self.db_tables = [
      tbl[0] for tbl in self.db.
      execute("SELECT name FROM sqlite_master WHERE type = 'table'").fetchall()
    ]
    return self.db_tables

  def read_sql(self, script: str, **kwds):

    if not self.db_loaded:
      raise ValueError('The DB table(s) must be loaded in order to use it!')

    return pd.read_sql(script, self.db, **kwds)

  def load(
    self,
    toCategories: bool = True,
    recode: bool = True,
    ageToInt: bool = True,
    **kwds
  ) -> pd.DataFrame:

    if 'chunksize' in kwds.keys():
      return self.loadChunk(toCategories, recode, ageToInt, **kwds)

    return self.loadFull(toCategories, recode, ageToInt, **kwds)
