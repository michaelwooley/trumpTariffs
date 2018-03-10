from src.IpumsExtract import IpumsExtract

ie = IpumsExtract(
  '../data/raw/usa_00022.dat.gz',
  '../data/raw/usa_00022.do',
  db_filename='../data/int/acs_2016.db'
)

ie.to_sql(compression='gzip')
