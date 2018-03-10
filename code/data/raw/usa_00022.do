* NOTE: You need to set the Stata working directory to the path
* where the data file is located.

set more off

clear
quietly infix                ///
  int     year        1-4    ///
  byte    datanum     5-6    ///
  double  serial      7-14   ///
  double  hhwt        15-24  ///
  byte    statefip    25-26  ///
  int     county      27-30  ///
  int     countyfips  31-33  ///
  byte    metro       34-34  ///
  int     city        35-38  ///
  long    puma        39-43  ///
  byte    gq          44-44  ///
  int     pernum      45-48  ///
  double  perwt       49-58  ///
  byte    sex         59-59  ///
  int     age         60-62  ///
  byte    school      63-63  ///
  byte    educ        64-65  ///
  int     educd       66-68  ///
  byte    empstat     69-69  ///
  byte    empstatd    70-71  ///
  byte    labforce    72-72  ///
  str     indnaics    73-80  ///
  long    inctot      81-87  ///
  long    incwage     88-93  ///
  using `"usa_00022.dat"'

replace hhwt       = hhwt       / 100
replace perwt      = perwt      / 100

format serial     %8.0f
format hhwt       %10.2f
format perwt      %10.2f

label var year       `"Census year"'
label var datanum    `"Data set number"'
label var serial     `"Household serial number"'
label var hhwt       `"Household weight"'
label var statefip   `"State (FIPS code)"'
label var county     `"County"'
label var countyfips `"County (FIPS code)"'
label var metro      `"Metropolitan status"'
label var city       `"City"'
label var puma       `"Public Use Microdata Area"'
label var gq         `"Group quarters status"'
label var pernum     `"Person number in sample unit"'
label var perwt      `"Person weight"'
label var sex        `"Sex"'
label var age        `"Age"'
label var school     `"School attendance"'
label var educ       `"Educational attainment [general version]"'
label var educd      `"Educational attainment [detailed version]"'
label var empstat    `"Employment status [general version]"'
label var empstatd   `"Employment status [detailed version]"'
label var labforce   `"Labor force status"'
label var indnaics   `"Industry, NAICS classification"'
label var inctot     `"Total personal income"'
label var incwage    `"Wage and salary income"'

label define year_lbl 1850 `"1850"'
label define year_lbl 1860 `"1860"', add
label define year_lbl 1870 `"1870"', add
label define year_lbl 1880 `"1880"', add
label define year_lbl 1900 `"1900"', add
label define year_lbl 1910 `"1910"', add
label define year_lbl 1920 `"1920"', add
label define year_lbl 1930 `"1930"', add
label define year_lbl 1940 `"1940"', add
label define year_lbl 1950 `"1950"', add
label define year_lbl 1960 `"1960"', add
label define year_lbl 1970 `"1970"', add
label define year_lbl 1980 `"1980"', add
label define year_lbl 1990 `"1990"', add
label define year_lbl 2000 `"2000"', add
label define year_lbl 2001 `"2001"', add
label define year_lbl 2002 `"2002"', add
label define year_lbl 2003 `"2003"', add
label define year_lbl 2004 `"2004"', add
label define year_lbl 2005 `"2005"', add
label define year_lbl 2006 `"2006"', add
label define year_lbl 2007 `"2007"', add
label define year_lbl 2008 `"2008"', add
label define year_lbl 2009 `"2009"', add
label define year_lbl 2010 `"2010"', add
label define year_lbl 2011 `"2011"', add
label define year_lbl 2012 `"2012"', add
label define year_lbl 2013 `"2013"', add
label define year_lbl 2014 `"2014"', add
label define year_lbl 2015 `"2015"', add
label define year_lbl 2016 `"2016"', add
label values year year_lbl

label define statefip_lbl 01 `"Alabama"'
label define statefip_lbl 02 `"Alaska"', add
label define statefip_lbl 04 `"Arizona"', add
label define statefip_lbl 05 `"Arkansas"', add
label define statefip_lbl 06 `"California"', add
label define statefip_lbl 08 `"Colorado"', add
label define statefip_lbl 09 `"Connecticut"', add
label define statefip_lbl 10 `"Delaware"', add
label define statefip_lbl 11 `"District of Columbia"', add
label define statefip_lbl 12 `"Florida"', add
label define statefip_lbl 13 `"Georgia"', add
label define statefip_lbl 15 `"Hawaii"', add
label define statefip_lbl 16 `"Idaho"', add
label define statefip_lbl 17 `"Illinois"', add
label define statefip_lbl 18 `"Indiana"', add
label define statefip_lbl 19 `"Iowa"', add
label define statefip_lbl 20 `"Kansas"', add
label define statefip_lbl 21 `"Kentucky"', add
label define statefip_lbl 22 `"Louisiana"', add
label define statefip_lbl 23 `"Maine"', add
label define statefip_lbl 24 `"Maryland"', add
label define statefip_lbl 25 `"Massachusetts"', add
label define statefip_lbl 26 `"Michigan"', add
label define statefip_lbl 27 `"Minnesota"', add
label define statefip_lbl 28 `"Mississippi"', add
label define statefip_lbl 29 `"Missouri"', add
label define statefip_lbl 30 `"Montana"', add
label define statefip_lbl 31 `"Nebraska"', add
label define statefip_lbl 32 `"Nevada"', add
label define statefip_lbl 33 `"New Hampshire"', add
label define statefip_lbl 34 `"New Jersey"', add
label define statefip_lbl 35 `"New Mexico"', add
label define statefip_lbl 36 `"New York"', add
label define statefip_lbl 37 `"North Carolina"', add
label define statefip_lbl 38 `"North Dakota"', add
label define statefip_lbl 39 `"Ohio"', add
label define statefip_lbl 40 `"Oklahoma"', add
label define statefip_lbl 41 `"Oregon"', add
label define statefip_lbl 42 `"Pennsylvania"', add
label define statefip_lbl 44 `"Rhode Island"', add
label define statefip_lbl 45 `"South Carolina"', add
label define statefip_lbl 46 `"South Dakota"', add
label define statefip_lbl 47 `"Tennessee"', add
label define statefip_lbl 48 `"Texas"', add
label define statefip_lbl 49 `"Utah"', add
label define statefip_lbl 50 `"Vermont"', add
label define statefip_lbl 51 `"Virginia"', add
label define statefip_lbl 53 `"Washington"', add
label define statefip_lbl 54 `"West Virginia"', add
label define statefip_lbl 55 `"Wisconsin"', add
label define statefip_lbl 56 `"Wyoming"', add
label define statefip_lbl 61 `"Maine-New Hampshire-Vermont"', add
label define statefip_lbl 62 `"Massachusetts-Rhode Island"', add
label define statefip_lbl 63 `"Minnesota-Iowa-Missouri-Kansas-Nebraska-S.Dakota-N.Dakota"', add
label define statefip_lbl 64 `"Maryland-Delaware"', add
label define statefip_lbl 65 `"Montana-Idaho-Wyoming"', add
label define statefip_lbl 66 `"Utah-Nevada"', add
label define statefip_lbl 67 `"Arizona-New Mexico"', add
label define statefip_lbl 68 `"Alaska-Hawaii"', add
label define statefip_lbl 72 `"Puerto Rico"', add
label define statefip_lbl 97 `"Military/Mil. Reservation"', add
label define statefip_lbl 99 `"State not identified"', add
label values statefip statefip_lbl

label define metro_lbl 0 `"Not identifiable"'
label define metro_lbl 1 `"Not in metro area"', add
label define metro_lbl 2 `"In metro area, central / principal city"', add
label define metro_lbl 3 `"In metro area, outside central / principal city"', add
label define metro_lbl 4 `"Central / Principal city status unknown"', add
label values metro metro_lbl

label define city_lbl 0000 `"Not in identifiable city (or size group)"'
label define city_lbl 0001 `"Aberdeen, SD"', add
label define city_lbl 0002 `"Aberdeen, WA"', add
label define city_lbl 0003 `"Abilene, TX"', add
label define city_lbl 0004 `"Ada, OK"', add
label define city_lbl 0005 `"Adams, MA"', add
label define city_lbl 0006 `"Adrian, MI"', add
label define city_lbl 0007 `"Abington, PA"', add
label define city_lbl 0010 `"Akron, OH"', add
label define city_lbl 0030 `"Alameda, CA"', add
label define city_lbl 0050 `"Albany, NY"', add
label define city_lbl 0051 `"Albany, GA"', add
label define city_lbl 0052 `"Albert Lea, MN"', add
label define city_lbl 0070 `"Albuquerque, NM"', add
label define city_lbl 0090 `"Alexandria, VA"', add
label define city_lbl 0091 `"Alexandria, LA"', add
label define city_lbl 0100 `"Alhambra, CA"', add
label define city_lbl 0110 `"Allegheny, PA"', add
label define city_lbl 0120 `"Aliquippa, PA"', add
label define city_lbl 0130 `"Allentown, PA"', add
label define city_lbl 0131 `"Alliance, OH"', add
label define city_lbl 0132 `"Alpena, MI"', add
label define city_lbl 0140 `"Alton, IL"', add
label define city_lbl 0150 `"Altoona, PA"', add
label define city_lbl 0160 `"Amarillo, TX"', add
label define city_lbl 0161 `"Ambridge, PA"', add
label define city_lbl 0162 `"Ames, IA"', add
label define city_lbl 0163 `"Amesbury, MA"', add
label define city_lbl 0170 `"Amsterdam, NY"', add
label define city_lbl 0171 `"Anaconda, MT"', add
label define city_lbl 0190 `"Anaheim, CA"', add
label define city_lbl 0210 `"Anchorage, AK"', add
label define city_lbl 0230 `"Anderson, IN"', add
label define city_lbl 0231 `"Anderson, SC"', add
label define city_lbl 0250 `"Andover, MA"', add
label define city_lbl 0270 `"Ann Arbor, MI"', add
label define city_lbl 0271 `"Annapolis, MD"', add
label define city_lbl 0272 `"Anniston, AL"', add
label define city_lbl 0273 `"Ansonia, CT"', add
label define city_lbl 0275 `"Antioch, CA"', add
label define city_lbl 0280 `"Appleton, WI"', add
label define city_lbl 0281 `"Ardmore, OK"', add
label define city_lbl 0282 `"Argenta, AR"', add
label define city_lbl 0283 `"Arkansas, KS"', add
label define city_lbl 0284 `"Arden-Arcade, CA"', add
label define city_lbl 0290 `"Arlington, TX"', add
label define city_lbl 0310 `"Arlington, VA"', add
label define city_lbl 0311 `"Arlington, MA"', add
label define city_lbl 0312 `"Arnold, PA"', add
label define city_lbl 0313 `"Asbury Park, NJ"', add
label define city_lbl 0330 `"Asheville, NC"', add
label define city_lbl 0331 `"Ashland, OH"', add
label define city_lbl 0340 `"Ashland, KY"', add
label define city_lbl 0341 `"Ashland, WI"', add
label define city_lbl 0342 `"Ashtabula, OH"', add
label define city_lbl 0343 `"Astoria, OR"', add
label define city_lbl 0344 `"Atchison, KS"', add
label define city_lbl 0345 `"Athens, GA"', add
label define city_lbl 0346 `"Athol, MA"', add
label define city_lbl 0347 `"Athens-Clarke County, GA"', add
label define city_lbl 0350 `"Atlanta, GA"', add
label define city_lbl 0370 `"Atlantic City, NJ"', add
label define city_lbl 0371 `"Attleboro, MA"', add
label define city_lbl 0390 `"Auburn, NY"', add
label define city_lbl 0391 `"Auburn, ME"', add
label define city_lbl 0410 `"Augusta, GA"', add
label define city_lbl 0411 `"Augusta-Richmond County, GA"', add
label define city_lbl 0430 `"Augusta, ME"', add
label define city_lbl 0450 `"Aurora, CO"', add
label define city_lbl 0470 `"Aurora, IL"', add
label define city_lbl 0490 `"Austin, TX"', add
label define city_lbl 0491 `"Austin, MN"', add
label define city_lbl 0510 `"Bakersfield, CA"', add
label define city_lbl 0530 `"Baltimore, MD"', add
label define city_lbl 0550 `"Bangor, ME"', add
label define city_lbl 0551 `"Barberton, OH"', add
label define city_lbl 0552 `"Barre, VT"', add
label define city_lbl 0553 `"Bartlesville, OK"', add
label define city_lbl 0554 `"Batavia, NY"', add
label define city_lbl 0570 `"Bath, ME"', add
label define city_lbl 0590 `"Baton Rouge, LA"', add
label define city_lbl 0610 `"Battle Creek, MI"', add
label define city_lbl 0630 `"Bay City, MI"', add
label define city_lbl 0640 `"Bayamon, PR"', add
label define city_lbl 0650 `"Bayonne, NJ"', add
label define city_lbl 0651 `"Beacon, NY"', add
label define city_lbl 0652 `"Beatrice, NE"', add
label define city_lbl 0660 `"Belleville, IL"', add
label define city_lbl 0670 `"Beaumont, TX"', add
label define city_lbl 0671 `"Beaver Falls, PA"', add
label define city_lbl 0672 `"Bedford, IN"', add
label define city_lbl 0673 `"Bellaire, OH"', add
label define city_lbl 0680 `"Bellevue, WA"', add
label define city_lbl 0690 `"Bellingham, WA"', add
label define city_lbl 0695 `"Belvedere, CA"', add
label define city_lbl 0700 `"Belleville, NJ"', add
label define city_lbl 0701 `"Bellevue, PA"', add
label define city_lbl 0702 `"Belmont, OH"', add
label define city_lbl 0703 `"Belmont, MA"', add
label define city_lbl 0704 `"Beloit, WI"', add
label define city_lbl 0705 `"Bennington, VT"', add
label define city_lbl 0706 `"Benton Harbor, MI"', add
label define city_lbl 0710 `"Berkeley, CA"', add
label define city_lbl 0711 `"Berlin, NH"', add
label define city_lbl 0712 `"Berwick, PA"', add
label define city_lbl 0720 `"Berwyn, IL"', add
label define city_lbl 0721 `"Bessemer, AL"', add
label define city_lbl 0730 `"Bethlehem, PA"', add
label define city_lbl 0740 `"Biddeford, ME"', add
label define city_lbl 0741 `"Big Spring, TX"', add
label define city_lbl 0742 `"Billings, MT"', add
label define city_lbl 0743 `"Biloxi, MS"', add
label define city_lbl 0750 `"Binghamton, NY"', add
label define city_lbl 0760 `"Beverly, MA"', add
label define city_lbl 0761 `"Beverly Hills, CA"', add
label define city_lbl 0770 `"Birmingham, AL"', add
label define city_lbl 0771 `"Birmingham, CT"', add
label define city_lbl 0772 `"Bismarck, ND"', add
label define city_lbl 0780 `"Bloomfield, NJ"', add
label define city_lbl 0790 `"Bloomington, IL"', add
label define city_lbl 0791 `"Bloomington, IN"', add
label define city_lbl 0792 `"Blue Island, IL"', add
label define city_lbl 0793 `"Bluefield, WV"', add
label define city_lbl 0794 `"Blytheville, AR"', add
label define city_lbl 0795 `"Bogalusa, LA"', add
label define city_lbl 0800 `"Boise, ID"', add
label define city_lbl 0801 `"Boone, IA"', add
label define city_lbl 0810 `"Boston, MA"', add
label define city_lbl 0811 `"Boulder, CO"', add
label define city_lbl 0812 `"Bowling Green, KY"', add
label define city_lbl 0813 `"Braddock, PA"', add
label define city_lbl 0814 `"Braden, WA"', add
label define city_lbl 0815 `"Bradford, PA"', add
label define city_lbl 0816 `"Brainerd, MN"', add
label define city_lbl 0817 `"Braintree, MA"', add
label define city_lbl 0818 `"Brawley, CA"', add
label define city_lbl 0819 `"Bremerton, WA"', add
label define city_lbl 0830 `"Bridgeport, CT"', add
label define city_lbl 0831 `"Bridgeton, NJ"', add
label define city_lbl 0832 `"Bristol, CT"', add
label define city_lbl 0833 `"Bristol, PA"', add
label define city_lbl 0834 `"Bristol, VA"', add
label define city_lbl 0835 `"Bristol, TN"', add
label define city_lbl 0837 `"Bristol, RI"', add
label define city_lbl 0850 `"Brockton, MA"', add
label define city_lbl 0851 `"Brookfield, IL"', add
label define city_lbl 0870 `"Brookline, MA"', add
label define city_lbl 0880 `"Brownsville, TX"', add
label define city_lbl 0881 `"Brownwood, TX"', add
label define city_lbl 0882 `"Brunswick, GA"', add
label define city_lbl 0883 `"Bucyrus, OH"', add
label define city_lbl 0890 `"Buffalo, NY"', add
label define city_lbl 0900 `"Burlington, IA"', add
label define city_lbl 0905 `"Burlington, VT"', add
label define city_lbl 0906 `"Burlington, NJ"', add
label define city_lbl 0907 `"Bushkill, PA"', add
label define city_lbl 0910 `"Butte, MT"', add
label define city_lbl 0911 `"Butler, PA"', add
label define city_lbl 0920 `"Burbank, CA"', add
label define city_lbl 0921 `"Burlingame, CA"', add
label define city_lbl 0926 `"Cairo, IL"', add
label define city_lbl 0927 `"Calumet City, IL"', add
label define city_lbl 0930 `"Cambridge, MA"', add
label define city_lbl 0931 `"Cambridge, OH"', add
label define city_lbl 0950 `"Camden, NJ"', add
label define city_lbl 0951 `"Campbell, OH"', add
label define city_lbl 0952 `"Canonsburg, PA"', add
label define city_lbl 0970 `"Camden, NY"', add
label define city_lbl 0990 `"Canton, OH"', add
label define city_lbl 0991 `"Canton, IL"', add
label define city_lbl 0992 `"Cape Girardeau, MO"', add
label define city_lbl 0993 `"Carbondale, PA"', add
label define city_lbl 0994 `"Carlisle, PA"', add
label define city_lbl 0995 `"Carnegie, PA"', add
label define city_lbl 0996 `"Carrick, PA"', add
label define city_lbl 0997 `"Carteret, NJ"', add
label define city_lbl 0998 `"Carthage, MO"', add
label define city_lbl 0999 `"Casper, WY"', add
label define city_lbl 1000 `"Cape Coral, FL"', add
label define city_lbl 1010 `"Cedar Rapids, IA"', add
label define city_lbl 1020 `"Central Falls, RI"', add
label define city_lbl 1021 `"Centralia, IL"', add
label define city_lbl 1023 `"Chambersburg, PA"', add
label define city_lbl 1024 `"Champaign, IL"', add
label define city_lbl 1025 `"Chanute, KS"', add
label define city_lbl 1026 `"Charleroi, PA"', add
label define city_lbl 1027 `"Chandler, AZ"', add
label define city_lbl 1030 `"Charlestown, MA"', add
label define city_lbl 1050 `"Charleston, SC"', add
label define city_lbl 1060 `"Carolina, PR"', add
label define city_lbl 1070 `"Charleston, WV"', add
label define city_lbl 1090 `"Charlotte, NC"', add
label define city_lbl 1091 `"Charlottesville, VA"', add
label define city_lbl 1110 `"Chattanooga, TN"', add
label define city_lbl 1130 `"Chelsea, MA"', add
label define city_lbl 1140 `"Cheltenham, PA"', add
label define city_lbl 1150 `"Chesapeake, VA"', add
label define city_lbl 1170 `"Chester, PA"', add
label define city_lbl 1171 `"Cheyenne, WY"', add
label define city_lbl 1190 `"Chicago, IL"', add
label define city_lbl 1191 `"Chicago Heights, IL"', add
label define city_lbl 1192 `"Chickasha, OK"', add
label define city_lbl 1210 `"Chicopee, MA"', add
label define city_lbl 1230 `"Chillicothe, OH"', add
label define city_lbl 1250 `"Chula Vista, CA"', add
label define city_lbl 1270 `"Cicero, IL"', add
label define city_lbl 1290 `"Cincinnati, OH"', add
label define city_lbl 1291 `"Clairton, PA"', add
label define city_lbl 1292 `"Claremont, NH"', add
label define city_lbl 1310 `"Clarksburg, WV"', add
label define city_lbl 1311 `"Clarksdale, MS"', add
label define city_lbl 1312 `"Cleburne, TX"', add
label define city_lbl 1330 `"Cleveland, OH"', add
label define city_lbl 1340 `"Cleveland Heights, OH"', add
label define city_lbl 1341 `"Cliffside Park, NJ"', add
label define city_lbl 1350 `"Clifton, NJ"', add
label define city_lbl 1351 `"Clinton, IN"', add
label define city_lbl 1370 `"Clinton, IA"', add
label define city_lbl 1371 `"Clinton, MA"', add
label define city_lbl 1372 `"Coatesville, PA"', add
label define city_lbl 1373 `"Coffeyville, KS"', add
label define city_lbl 1374 `"Cohoes, NY"', add
label define city_lbl 1375 `"Collingswood, NJ"', add
label define city_lbl 1390 `"Colorado Springs, CO"', add
label define city_lbl 1400 `"Cohoes, NY"', add
label define city_lbl 1410 `"Columbia, SC"', add
label define city_lbl 1411 `"Columbia, PA"', add
label define city_lbl 1412 `"Columbia, MO"', add
label define city_lbl 1420 `"Columbia City, IN"', add
label define city_lbl 1430 `"Columbus, GA"', add
label define city_lbl 1450 `"Columbus, OH"', add
label define city_lbl 1451 `"Columbus, MS"', add
label define city_lbl 1452 `"Compton, CA"', add
label define city_lbl 1470 `"Concord, CA"', add
label define city_lbl 1490 `"Concord, NH"', add
label define city_lbl 1491 `"Concord, NC"', add
label define city_lbl 1492 `"Connellsville, PA"', add
label define city_lbl 1493 `"Connersville, IN"', add
label define city_lbl 1494 `"Conshohocken, PA"', add
label define city_lbl 1495 `"Coraopolis, PA"', add
label define city_lbl 1496 `"Corning, NY"', add
label define city_lbl 1500 `"Corona, CA"', add
label define city_lbl 1510 `"Council Bluffs, IA"', add
label define city_lbl 1520 `"Corpus Christi, TX"', add
label define city_lbl 1521 `"Corsicana, TX"', add
label define city_lbl 1522 `"Cortland, NY"', add
label define city_lbl 1523 `"Coshocton, OH"', add
label define city_lbl 1530 `"Covington, KY"', add
label define city_lbl 1540 `"Costa Mesa, CA"', add
label define city_lbl 1545 `"Cranford, NJ"', add
label define city_lbl 1550 `"Cranston, RI"', add
label define city_lbl 1551 `"Crawfordsville, IN"', add
label define city_lbl 1552 `"Cripple Creek, CO"', add
label define city_lbl 1553 `"Cudahy, WI"', add
label define city_lbl 1570 `"Cumberland, MD"', add
label define city_lbl 1571 `"Cumberland, RI"', add
label define city_lbl 1572 `"Cuyahoga Falls, OH"', add
label define city_lbl 1590 `"Dallas, TX"', add
label define city_lbl 1591 `"Danbury, CT"', add
label define city_lbl 1592 `"Daly City, CA"', add
label define city_lbl 1610 `"Danvers, MA"', add
label define city_lbl 1630 `"Danville, IL"', add
label define city_lbl 1631 `"Danville, VA"', add
label define city_lbl 1650 `"Davenport, IA"', add
label define city_lbl 1670 `"Dayton, OH"', add
label define city_lbl 1671 `"Daytona Beach, FL"', add
label define city_lbl 1680 `"Dearborn, MI"', add
label define city_lbl 1690 `"Decatur, IL"', add
label define city_lbl 1691 `"Decatur, AL"', add
label define city_lbl 1692 `"Decatur, GA"', add
label define city_lbl 1693 `"Dedham, MA"', add
label define city_lbl 1694 `"Del Rio, TX"', add
label define city_lbl 1695 `"Denison, TX"', add
label define city_lbl 1710 `"Denver, CO"', add
label define city_lbl 1711 `"Derby, CT"', add
label define city_lbl 1713 `"Derry, PA"', add
label define city_lbl 1730 `"Des Moines, IA"', add
label define city_lbl 1750 `"Detroit, MI"', add
label define city_lbl 1751 `"Dickson City, PA"', add
label define city_lbl 1752 `"Dodge, KS"', add
label define city_lbl 1753 `"Donora, PA"', add
label define city_lbl 1754 `"Dormont, PA"', add
label define city_lbl 1755 `"Dothan, AL"', add
label define city_lbl 1770 `"Dorchester, MA"', add
label define city_lbl 1790 `"Dover, NH"', add
label define city_lbl 1791 `"Dover, NJ"', add
label define city_lbl 1792 `"Du Bois, PA"', add
label define city_lbl 1800 `"Downey, CA"', add
label define city_lbl 1810 `"Dubuque, IA"', add
label define city_lbl 1830 `"Duluth, MN"', add
label define city_lbl 1831 `"Dunkirk, NY"', add
label define city_lbl 1832 `"Dunmore, PA"', add
label define city_lbl 1833 `"Duquesne, PA"', add
label define city_lbl 1834 `"Dundalk, MD"', add
label define city_lbl 1850 `"Durham, NC"', add
label define city_lbl 1860 `"1860"', add
label define city_lbl 1870 `"East Chicago, IN"', add
label define city_lbl 1890 `"East Cleveland, OH"', add
label define city_lbl 1891 `"East Hartford, CT"', add
label define city_lbl 1892 `"East Liverpool, OH"', add
label define city_lbl 1893 `"East Moline, IL"', add
label define city_lbl 1910 `"East Los Angeles, CA"', add
label define city_lbl 1930 `"East Orange, NJ"', add
label define city_lbl 1931 `"East Providence, RI"', add
label define city_lbl 1940 `"East Saginaw, MI"', add
label define city_lbl 1950 `"East St. Louis, IL"', add
label define city_lbl 1951 `"East Youngstown, OH"', add
label define city_lbl 1952 `"Easthampton, MA"', add
label define city_lbl 1970 `"Easton, PA"', add
label define city_lbl 1971 `"Eau Claire, WI"', add
label define city_lbl 1972 `"Ecorse, MI"', add
label define city_lbl 1973 `"El Dorado, KS"', add
label define city_lbl 1974 `"El Dorado, AR"', add
label define city_lbl 1990 `"El Monte, CA"', add
label define city_lbl 2010 `"El Paso, TX"', add
label define city_lbl 2030 `"Elgin, IL"', add
label define city_lbl 2040 `"Elyria, OH"', add
label define city_lbl 2050 `"Elizabeth, NJ"', add
label define city_lbl 2051 `"Elizabeth City, NC"', add
label define city_lbl 2055 `"Elk Grove, CA"', add
label define city_lbl 2060 `"Elkhart, IN"', add
label define city_lbl 2061 `"Ellwood City, PA"', add
label define city_lbl 2062 `"Elmhurst, IL"', add
label define city_lbl 2070 `"Elmira, NY"', add
label define city_lbl 2071 `"Elmwood Park, IL"', add
label define city_lbl 2072 `"Elwood, IN"', add
label define city_lbl 2073 `"Emporia, KS"', add
label define city_lbl 2074 `"Endicott, NY"', add
label define city_lbl 2075 `"Enfield, CT"', add
label define city_lbl 2076 `"Englewood, NJ"', add
label define city_lbl 2080 `"Enid, OK"', add
label define city_lbl 2090 `"Erie, PA"', add
label define city_lbl 2091 `"Escanaba, MI"', add
label define city_lbl 2092 `"Euclid, OH"', add
label define city_lbl 2110 `"Escondido, CA"', add
label define city_lbl 2130 `"Eugene, OR"', add
label define city_lbl 2131 `"Eureka, CA"', add
label define city_lbl 2150 `"Evanston, IL"', add
label define city_lbl 2170 `"Evansville, IN"', add
label define city_lbl 2190 `"Everett, MA"', add
label define city_lbl 2210 `"Everett, WA"', add
label define city_lbl 2211 `"Fairfield, AL"', add
label define city_lbl 2212 `"Fairfield, CT"', add
label define city_lbl 2213 `"Fairhaven, MA"', add
label define city_lbl 2214 `"Fairmont, WV"', add
label define city_lbl 2220 `"Fargo, ND"', add
label define city_lbl 2221 `"Faribault, MN"', add
label define city_lbl 2222 `"Farrell, PA"', add
label define city_lbl 2230 `"Fall River, MA"', add
label define city_lbl 2240 `"Fayetteville, NC"', add
label define city_lbl 2241 `"Ferndale, MI"', add
label define city_lbl 2242 `"Findlay, OH"', add
label define city_lbl 2250 `"Fitchburg, MA"', add
label define city_lbl 2260 `"Fontana, CA"', add
label define city_lbl 2270 `"Flint, MI"', add
label define city_lbl 2271 `"Floral Park, NY"', add
label define city_lbl 2273 `"Florence, AL"', add
label define city_lbl 2274 `"Florence, SC"', add
label define city_lbl 2275 `"Flushing, NY"', add
label define city_lbl 2280 `"Fond du Lac, WI"', add
label define city_lbl 2281 `"Forest Park, IL"', add
label define city_lbl 2290 `"Fort Lauderdale, FL"', add
label define city_lbl 2300 `"Fort Collins, CO"', add
label define city_lbl 2301 `"Fort Dodge, IA"', add
label define city_lbl 2302 `"Fort Madison, IA"', add
label define city_lbl 2303 `"Fort Scott, KS"', add
label define city_lbl 2310 `"Fort Smith, AR"', add
label define city_lbl 2311 `"Fort Thomas, KY"', add
label define city_lbl 2330 `"Fort Wayne, IN"', add
label define city_lbl 2350 `"Fort Worth, TX"', add
label define city_lbl 2351 `"Fostoria, OH"', add
label define city_lbl 2352 `"Framingham, MA"', add
label define city_lbl 2353 `"Frankfort, IN"', add
label define city_lbl 2354 `"Frankfort, KY"', add
label define city_lbl 2355 `"Franklin, PA"', add
label define city_lbl 2356 `"Frederick, MD"', add
label define city_lbl 2357 `"Freeport, NY"', add
label define city_lbl 2358 `"Freeport, IL"', add
label define city_lbl 2359 `"Fremont, OH"', add
label define city_lbl 2360 `"Fremont, NE"', add
label define city_lbl 2370 `"Fresno, CA"', add
label define city_lbl 2390 `"Fullerton, CA"', add
label define city_lbl 2391 `"Fulton, NY"', add
label define city_lbl 2392 `"Gadsden, AL"', add
label define city_lbl 2393 `"Galena, KS"', add
label define city_lbl 2394 `"Gainseville, FL"', add
label define city_lbl 2400 `"Galesburg, IL"', add
label define city_lbl 2410 `"Galveston, TX"', add
label define city_lbl 2411 `"Gardner, MA"', add
label define city_lbl 2430 `"Garden Grove, CA"', add
label define city_lbl 2435 `"Gardena, CA"', add
label define city_lbl 2440 `"Garfield, NJ"', add
label define city_lbl 2441 `"Garfield Heights, OH"', add
label define city_lbl 2450 `"Garland, TX"', add
label define city_lbl 2470 `"Gary, IN"', add
label define city_lbl 2471 `"Gastonia, NC"', add
label define city_lbl 2472 `"Geneva, NY"', add
label define city_lbl 2473 `"Glen Cove, NY"', add
label define city_lbl 2489 `"Glendale, AZ"', add
label define city_lbl 2490 `"Glendale, CA"', add
label define city_lbl 2491 `"Glens Falls, NY"', add
label define city_lbl 2510 `"Gloucester, MA"', add
label define city_lbl 2511 `"Gloucester, NJ"', add
label define city_lbl 2512 `"Gloversville, NY"', add
label define city_lbl 2513 `"Goldsboro, NC"', add
label define city_lbl 2514 `"Goshen, IN"', add
label define city_lbl 2515 `"Grand Forks, ND"', add
label define city_lbl 2516 `"Grand Island, NE"', add
label define city_lbl 2517 `"Grand Junction, CO"', add
label define city_lbl 2520 `"Granite City, IL"', add
label define city_lbl 2530 `"Grand Rapids, MI"', add
label define city_lbl 2531 `"Grandville, MI"', add
label define city_lbl 2540 `"Great Falls, MT"', add
label define city_lbl 2541 `"Greeley, CO"', add
label define city_lbl 2550 `"Green Bay, WI"', add
label define city_lbl 2551 `"Greenfield, MA"', add
label define city_lbl 2570 `"Greensboro, NC"', add
label define city_lbl 2571 `"Greensburg, PA"', add
label define city_lbl 2572 `"Greenville, MS"', add
label define city_lbl 2573 `"Greenville, SC"', add
label define city_lbl 2574 `"Greenville, TX"', add
label define city_lbl 2575 `"Greenwich, CT"', add
label define city_lbl 2576 `"Greenwood, MS"', add
label define city_lbl 2577 `"Greenwood, SC"', add
label define city_lbl 2578 `"Griffin, GA"', add
label define city_lbl 2579 `"Grosse Pointe Park, MI"', add
label define city_lbl 2580 `"Guynabo, PR"', add
label define city_lbl 2581 `"Groton, CT"', add
label define city_lbl 2582 `"Gulfport, MS"', add
label define city_lbl 2583 `"Guthrie, OK"', add
label define city_lbl 2584 `"Hackensack, NJ"', add
label define city_lbl 2590 `"Hagerstown, MD"', add
label define city_lbl 2591 `"Hamden, CT"', add
label define city_lbl 2610 `"Hamilton, OH"', add
label define city_lbl 2630 `"Hammond, IN"', add
label define city_lbl 2650 `"Hampton, VA"', add
label define city_lbl 2670 `"Hamtramck Village, MI"', add
label define city_lbl 2680 `"Hannibal, MO"', add
label define city_lbl 2681 `"Hanover, PA"', add
label define city_lbl 2682 `"Harlingen, TX"', add
label define city_lbl 2683 `"Hanover township, Luzerne county, PA"', add
label define city_lbl 2690 `"Harrisburg, PA"', add
label define city_lbl 2691 `"Harrisburg, IL"', add
label define city_lbl 2692 `"Harrison, NJ"', add
label define city_lbl 2693 `"Harrison, PA"', add
label define city_lbl 2710 `"Hartford, CT"', add
label define city_lbl 2711 `"Harvey, IL"', add
label define city_lbl 2712 `"Hastings, NE"', add
label define city_lbl 2713 `"Hattiesburg, MS"', add
label define city_lbl 2725 `"Haverford, PA"', add
label define city_lbl 2730 `"Haverhill, MA"', add
label define city_lbl 2731 `"Hawthorne, NJ"', add
label define city_lbl 2740 `"Hayward, CA"', add
label define city_lbl 2750 `"Hazleton, PA"', add
label define city_lbl 2751 `"Helena, MT"', add
label define city_lbl 2752 `"Hempstead, NY"', add
label define city_lbl 2753 `"Henderson, KY"', add
label define city_lbl 2754 `"Herkimer, NY"', add
label define city_lbl 2755 `"Herrin, IL"', add
label define city_lbl 2756 `"Hibbing, MN"', add
label define city_lbl 2757 `"Henderson, NV"', add
label define city_lbl 2770 `"Hialeah, FL"', add
label define city_lbl 2780 `"High Point, NC"', add
label define city_lbl 2781 `"Highland Park, IL"', add
label define city_lbl 2790 `"Highland Park, MI"', add
label define city_lbl 2791 `"Hilo, HI"', add
label define city_lbl 2792 `"Hillside, NJ"', add
label define city_lbl 2810 `"Hoboken, NJ"', add
label define city_lbl 2811 `"Holland, MI"', add
label define city_lbl 2830 `"Hollywood, FL"', add
label define city_lbl 2850 `"Holyoke, MA"', add
label define city_lbl 2851 `"Homestead, PA"', add
label define city_lbl 2870 `"Honolulu, HI"', add
label define city_lbl 2871 `"Hopewell, VA"', add
label define city_lbl 2872 `"Hopkinsville, KY"', add
label define city_lbl 2873 `"Hoquiam, WA"', add
label define city_lbl 2874 `"Hornell, NY"', add
label define city_lbl 2875 `"Hot Springs, AR"', add
label define city_lbl 2890 `"Houston, TX"', add
label define city_lbl 2891 `"Hudson, NY"', add
label define city_lbl 2892 `"Huntington, IN"', add
label define city_lbl 2910 `"Huntington, WV"', add
label define city_lbl 2930 `"Huntington Beach, CA"', add
label define city_lbl 2950 `"Huntsville, AL"', add
label define city_lbl 2951 `"Huron, SD"', add
label define city_lbl 2960 `"Hutchinson, KS"', add
label define city_lbl 2961 `"Hyde Park, MA"', add
label define city_lbl 2962 `"Ilion, NY"', add
label define city_lbl 2963 `"Independence, KS"', add
label define city_lbl 2970 `"Independence, MO"', add
label define city_lbl 2990 `"Indianapolis, IN"', add
label define city_lbl 3010 `"Inglewood, CA"', add
label define city_lbl 3011 `"Iowa City, IA"', add
label define city_lbl 3012 `"Iron Mountain, MI"', add
label define city_lbl 3013 `"Ironton, OH"', add
label define city_lbl 3014 `"Ironwood, MI"', add
label define city_lbl 3015 `"Irondequoit, NY"', add
label define city_lbl 3020 `"Irvine, CA"', add
label define city_lbl 3030 `"Irving, TX"', add
label define city_lbl 3050 `"Irvington, NJ"', add
label define city_lbl 3051 `"Ishpeming, MI"', add
label define city_lbl 3052 `"Ithaca, NY"', add
label define city_lbl 3070 `"Jackson, MI"', add
label define city_lbl 3071 `"Jackson, MN"', add
label define city_lbl 3090 `"Jackson, MS"', add
label define city_lbl 3091 `"Jackson, TN"', add
label define city_lbl 3110 `"Jacksonville, FL"', add
label define city_lbl 3111 `"Jacksonville, IL"', add
label define city_lbl 3130 `"Jamestown , NY"', add
label define city_lbl 3131 `"Janesville, WI"', add
label define city_lbl 3132 `"Jeannette, PA"', add
label define city_lbl 3133 `"Jefferson City, MO"', add
label define city_lbl 3134 `"Jeffersonville, IN"', add
label define city_lbl 3150 `"Jersey City, NJ"', add
label define city_lbl 3151 `"Johnson City, NY"', add
label define city_lbl 3160 `"Johnson City, TN"', add
label define city_lbl 3161 `"Johnstown, NY"', add
label define city_lbl 3170 `"Johnstown, PA"', add
label define city_lbl 3190 `"Joliet, IL"', add
label define city_lbl 3191 `"Jonesboro, AR"', add
label define city_lbl 3210 `"Joplin, MO"', add
label define city_lbl 3230 `"Kalamazoo, MI"', add
label define city_lbl 3231 `"Kankakee, IL"', add
label define city_lbl 3250 `"Kansas City, KS"', add
label define city_lbl 3260 `"Kansas City, MO"', add
label define city_lbl 3270 `"Kearny, NJ"', add
label define city_lbl 3271 `"Keene, NH"', add
label define city_lbl 3272 `"Kenmore, NY"', add
label define city_lbl 3273 `"Kenmore, OH"', add
label define city_lbl 3290 `"Kenosha, WI"', add
label define city_lbl 3291 `"Keokuk, IA"', add
label define city_lbl 3292 `"Kewanee, IL"', add
label define city_lbl 3293 `"Key West, FL"', add
label define city_lbl 3294 `"Kingsport, TN"', add
label define city_lbl 3310 `"Kingston, NY"', add
label define city_lbl 3311 `"Kingston, PA"', add
label define city_lbl 3312 `"Kinston, NC"', add
label define city_lbl 3313 `"Klamath Falls, OR"', add
label define city_lbl 3330 `"Knoxville, TN"', add
label define city_lbl 3350 `"Kokomo, IN"', add
label define city_lbl 3370 `"La Crosse, WI"', add
label define city_lbl 3380 `"Lafayette, IN"', add
label define city_lbl 3390 `"Lafayette, LA"', add
label define city_lbl 3391 `"La Grange, IL"', add
label define city_lbl 3392 `"La Grange, GA"', add
label define city_lbl 3393 `"La Porte, IN"', add
label define city_lbl 3394 `"La Salle, IL"', add
label define city_lbl 3395 `"Lackawanna, NY"', add
label define city_lbl 3396 `"Laconia, NH"', add
label define city_lbl 3400 `"Lake Charles, LA"', add
label define city_lbl 3405 `"Lakeland, FL"', add
label define city_lbl 3410 `"Lakewood, CO"', add
label define city_lbl 3430 `"Lakewood, OH"', add
label define city_lbl 3440 `"Lancaster, CA"', add
label define city_lbl 3450 `"Lancaster, PA"', add
label define city_lbl 3451 `"Lancaster, OH"', add
label define city_lbl 3470 `"Lansing, MI"', add
label define city_lbl 3471 `"Lansingburgh, NY"', add
label define city_lbl 3480 `"Laredo, TX"', add
label define city_lbl 3481 `"Latrobe, PA"', add
label define city_lbl 3482 `"Laurel, MS"', add
label define city_lbl 3490 `"Las Vegas, NV"', add
label define city_lbl 3510 `"Lawrence, MA"', add
label define city_lbl 3511 `"Lawrence, KS"', add
label define city_lbl 3512 `"Lawton, OK"', add
label define city_lbl 3513 `"Leadville, CO"', add
label define city_lbl 3520 `"Leavenworth, KS"', add
label define city_lbl 3521 `"Lebanon, PA"', add
label define city_lbl 3522 `"Leominster, MA"', add
label define city_lbl 3530 `"Lehigh, PA"', add
label define city_lbl 3540 `"Lebanon, PA"', add
label define city_lbl 3550 `"Lewiston, ME"', add
label define city_lbl 3551 `"Lewistown, PA"', add
label define city_lbl 3560 `"Lewisville, TX"', add
label define city_lbl 3570 `"Lexington, KY"', add
label define city_lbl 3590 `"Lexington-Fayette, KY"', add
label define city_lbl 3610 `"Lima, OH"', add
label define city_lbl 3630 `"Lincoln, NE"', add
label define city_lbl 3631 `"Lincoln, IL"', add
label define city_lbl 3632 `"Lincoln Park, MI"', add
label define city_lbl 3633 `"Lincoln, RI"', add
label define city_lbl 3634 `"Linden, NJ"', add
label define city_lbl 3635 `"Little Falls, NY"', add
label define city_lbl 3638 `"Lodi, NJ"', add
label define city_lbl 3639 `"Logansport, IN"', add
label define city_lbl 3650 `"Little Rock, AR"', add
label define city_lbl 3670 `"Livonia, MI"', add
label define city_lbl 3680 `"Lockport, NY"', add
label define city_lbl 3690 `"Long Beach, CA"', add
label define city_lbl 3691 `"Long Branch, NJ"', add
label define city_lbl 3692 `"Long Island City, NY"', add
label define city_lbl 3693 `"Longview, WA"', add
label define city_lbl 3710 `"Lorain, OH"', add
label define city_lbl 3730 `"Los Angeles, CA"', add
label define city_lbl 3750 `"Louisville, KY"', add
label define city_lbl 3765 `"Lower Merion, PA"', add
label define city_lbl 3770 `"Lowell, MA"', add
label define city_lbl 3771 `"Lubbock, TX"', add
label define city_lbl 3772 `"Lynbrook, NY"', add
label define city_lbl 3790 `"Lynchburg, VA"', add
label define city_lbl 3800 `"Lyndhurst, NJ"', add
label define city_lbl 3810 `"Lynn, MA"', add
label define city_lbl 3830 `"Macon, GA"', add
label define city_lbl 3850 `"Madison, IN"', add
label define city_lbl 3870 `"Madison, WI"', add
label define city_lbl 3871 `"Mahanoy City, PA"', add
label define city_lbl 3890 `"Malden, MA"', add
label define city_lbl 3891 `"Mamaroneck, NY"', add
label define city_lbl 3910 `"Manchester, NH"', add
label define city_lbl 3911 `"Manchester, CT"', add
label define city_lbl 3912 `"Manhattan, KS"', add
label define city_lbl 3913 `"Manistee, MI"', add
label define city_lbl 3914 `"Manitowoc, WI"', add
label define city_lbl 3915 `"Mankato, MN"', add
label define city_lbl 3929 `"Maplewood, NJ"', add
label define city_lbl 3930 `"Mansfield, OH"', add
label define city_lbl 3931 `"Maplewood, MO"', add
label define city_lbl 3932 `"Marietta, OH"', add
label define city_lbl 3933 `"Marinette, WI"', add
label define city_lbl 3934 `"Marion, IN"', add
label define city_lbl 3940 `"Maywood, IL"', add
label define city_lbl 3950 `"Marion, OH"', add
label define city_lbl 3951 `"Marlborough, MA"', add
label define city_lbl 3952 `"Marquette, MI"', add
label define city_lbl 3953 `"Marshall, TX"', add
label define city_lbl 3954 `"Marshalltown, IA"', add
label define city_lbl 3955 `"Martins Ferry, OH"', add
label define city_lbl 3956 `"Martinsburg, WV"', add
label define city_lbl 3957 `"Mason City, IA"', add
label define city_lbl 3958 `"Massena, NY"', add
label define city_lbl 3959 `"Massillon, OH"', add
label define city_lbl 3960 `"McAllen, TX"', add
label define city_lbl 3961 `"Mattoon, IL"', add
label define city_lbl 3962 `"Mcalester, OK"', add
label define city_lbl 3963 `"Mccomb, MS"', add
label define city_lbl 3964 `"Mckees Rocks, PA"', add
label define city_lbl 3970 `"McKeesport, PA"', add
label define city_lbl 3971 `"Meadville, PA"', add
label define city_lbl 3990 `"Medford, MA"', add
label define city_lbl 3991 `"Medford, OR"', add
label define city_lbl 3992 `"Melrose, MA"', add
label define city_lbl 3993 `"Melrose Park, IL"', add
label define city_lbl 4010 `"Memphis, TN"', add
label define city_lbl 4011 `"Menominee, MI"', add
label define city_lbl 4030 `"Meriden, CT"', add
label define city_lbl 4040 `"Meridian, MS"', add
label define city_lbl 4041 `"Methuen, MA"', add
label define city_lbl 4050 `"Mesa, AZ"', add
label define city_lbl 4070 `"Mesquite, TX"', add
label define city_lbl 4090 `"Metairie, LA"', add
label define city_lbl 4110 `"Miami, FL"', add
label define city_lbl 4120 `"Michigan City, IN"', add
label define city_lbl 4121 `"Middlesborough, KY"', add
label define city_lbl 4122 `"Middletown, CT"', add
label define city_lbl 4123 `"Middletown, NY"', add
label define city_lbl 4124 `"Middletown, OH"', add
label define city_lbl 4125 `"Milford, CT"', add
label define city_lbl 4126 `"Milford, MA"', add
label define city_lbl 4127 `"Millville, NJ"', add
label define city_lbl 4128 `"Milton, MA"', add
label define city_lbl 4130 `"Milwaukee, WI"', add
label define city_lbl 4150 `"Minneapolis, MN"', add
label define city_lbl 4151 `"Minot, ND"', add
label define city_lbl 4160 `"Mishawaka, IN"', add
label define city_lbl 4161 `"Missoula, MT"', add
label define city_lbl 4162 `"Mitchell, SD"', add
label define city_lbl 4163 `"Moberly, MO"', add
label define city_lbl 4170 `"Mobile, AL"', add
label define city_lbl 4190 `"Modesto, CA"', add
label define city_lbl 4210 `"Moline, IL"', add
label define city_lbl 4211 `"Monessen, PA"', add
label define city_lbl 4212 `"Monroe, MI"', add
label define city_lbl 4213 `"Monroe, LA"', add
label define city_lbl 4214 `"Monrovia, CA"', add
label define city_lbl 4230 `"Montclair, NJ"', add
label define city_lbl 4250 `"Montgomery, AL"', add
label define city_lbl 4251 `"Morgantown, WV"', add
label define city_lbl 4252 `"Morristown, NJ"', add
label define city_lbl 4253 `"Moundsville, WV"', add
label define city_lbl 4254 `"Mount Arlington, NJ"', add
label define city_lbl 4255 `"Mount Carmel, PA"', add
label define city_lbl 4256 `"Mount Clemens, MI"', add
label define city_lbl 4260 `"Mount Lebanon, PA"', add
label define city_lbl 4270 `"Moreno Valley, CA"', add
label define city_lbl 4290 `"Mount Vernon, NY"', add
label define city_lbl 4291 `"Mount Vernon, IL"', add
label define city_lbl 4310 `"Muncie, IN"', add
label define city_lbl 4311 `"Munhall, PA"', add
label define city_lbl 4312 `"Murphysboro, IL"', add
label define city_lbl 4313 `"Muscatine, IA"', add
label define city_lbl 4330 `"Muskegon, MI"', add
label define city_lbl 4331 `"Muskegon Heights, MI"', add
label define city_lbl 4350 `"Muskogee, OK"', add
label define city_lbl 4351 `"Nanticoke, PA"', add
label define city_lbl 4370 `"Nantucket, MA"', add
label define city_lbl 4390 `"Nashua, NH"', add
label define city_lbl 4410 `"Nashville-Davidson, TN"', add
label define city_lbl 4411 `"Nashville, TN"', add
label define city_lbl 4413 `"Natchez, MS"', add
label define city_lbl 4414 `"Natick, MA"', add
label define city_lbl 4415 `"Naugatuck, CT"', add
label define city_lbl 4416 `"Needham, MA"', add
label define city_lbl 4420 `"Neptune, NJ"', add
label define city_lbl 4430 `"New Albany, IN"', add
label define city_lbl 4450 `"New Bedford, MA"', add
label define city_lbl 4451 `"New Bern, NC"', add
label define city_lbl 4452 `"New Brighton, NY"', add
label define city_lbl 4470 `"New Britain, CT"', add
label define city_lbl 4490 `"New Brunswick, NJ"', add
label define city_lbl 4510 `"New Castle, PA"', add
label define city_lbl 4511 `"New Castle, IN"', add
label define city_lbl 4530 `"New Haven, CT"', add
label define city_lbl 4550 `"New London, CT"', add
label define city_lbl 4570 `"New Orleans, LA"', add
label define city_lbl 4571 `"New Philadelphia, OH"', add
label define city_lbl 4590 `"New Rochelle, NY"', add
label define city_lbl 4610 `"New York, NY"', add
label define city_lbl 4611 `"Brooklyn (only in census years before 1900)"', add
label define city_lbl 4630 `"Newark, NJ"', add
label define city_lbl 4650 `"Newark, OH"', add
label define city_lbl 4670 `"Newburgh, NY"', add
label define city_lbl 4690 `"Newburyport, MA"', add
label define city_lbl 4710 `"Newport, KY"', add
label define city_lbl 4730 `"Newport, RI"', add
label define city_lbl 4750 `"Newport News, VA"', add
label define city_lbl 4770 `"Newton, MA"', add
label define city_lbl 4771 `"Newton, IA"', add
label define city_lbl 4772 `"Newton, KS"', add
label define city_lbl 4790 `"Niagara Falls, NY"', add
label define city_lbl 4791 `"Niles, MI"', add
label define city_lbl 4792 `"Niles, OH"', add
label define city_lbl 4810 `"Norfolk, VA"', add
label define city_lbl 4811 `"Norfolk, NE"', add
label define city_lbl 4820 `"North Las Vegas, NV"', add
label define city_lbl 4830 `"Norristown Borough, PA"', add
label define city_lbl 4831 `"North Adams, MA"', add
label define city_lbl 4832 `"North Attleborough, MA"', add
label define city_lbl 4833 `"North Bennington, VT"', add
label define city_lbl 4834 `"North Braddock, PA"', add
label define city_lbl 4835 `"North Branford, CT"', add
label define city_lbl 4836 `"North Haven, CT"', add
label define city_lbl 4837 `"North Little Rock, AR"', add
label define city_lbl 4838 `"North Platte, NE"', add
label define city_lbl 4839 `"North Providence, RI"', add
label define city_lbl 4840 `"Northampton, MA"', add
label define city_lbl 4841 `"North Tonawanda, NY"', add
label define city_lbl 4842 `"North Yakima, WA"', add
label define city_lbl 4843 `"Northbridge, MA"', add
label define city_lbl 4845 `"North Bergen, NJ"', add
label define city_lbl 4850 `"North Providence, RI"', add
label define city_lbl 4860 `"Norwalk, CA"', add
label define city_lbl 4870 `"Norwalk, CT"', add
label define city_lbl 4890 `"Norwich, CT"', add
label define city_lbl 4900 `"Norwood, OH"', add
label define city_lbl 4901 `"Norwood, MA"', add
label define city_lbl 4902 `"Nutley, NJ"', add
label define city_lbl 4905 `"Oak Park, IL"', add
label define city_lbl 4910 `"Oak Park Village"', add
label define city_lbl 4930 `"Oakland, CA"', add
label define city_lbl 4950 `"Oceanside, CA"', add
label define city_lbl 4970 `"Ogden, UT"', add
label define city_lbl 4971 `"Ogdensburg, NY"', add
label define city_lbl 4972 `"Oil City, PA"', add
label define city_lbl 4990 `"Oklahoma City, OK"', add
label define city_lbl 4991 `"Okmulgee, OK"', add
label define city_lbl 4992 `"Old Bennington, VT"', add
label define city_lbl 4993 `"Old Forge, PA"', add
label define city_lbl 4994 `"Olean, NY"', add
label define city_lbl 4995 `"Olympia, WA"', add
label define city_lbl 4996 `"Olyphant, PA"', add
label define city_lbl 5010 `"Omaha, NE"', add
label define city_lbl 5011 `"Oneida, NY"', add
label define city_lbl 5012 `"Oneonta, NY"', add
label define city_lbl 5030 `"Ontario, CA"', add
label define city_lbl 5040 `"Orange, CA"', add
label define city_lbl 5050 `"Orange, NJ"', add
label define city_lbl 5051 `"Orange, CT"', add
label define city_lbl 5070 `"Orlando, FL"', add
label define city_lbl 5090 `"Oshkosh, WI"', add
label define city_lbl 5091 `"Oskaloosa, IA"', add
label define city_lbl 5092 `"Ossining, NY"', add
label define city_lbl 5110 `"Oswego, NY"', add
label define city_lbl 5111 `"Ottawa, IL"', add
label define city_lbl 5112 `"Ottumwa, IA"', add
label define city_lbl 5113 `"Owensboro, KY"', add
label define city_lbl 5114 `"Owosso, MI"', add
label define city_lbl 5116 `"Painesville, OH"', add
label define city_lbl 5117 `"Palestine, TX"', add
label define city_lbl 5118 `"Palo Alto, CA"', add
label define city_lbl 5119 `"Pampa, TX"', add
label define city_lbl 5121 `"Paris, TX"', add
label define city_lbl 5122 `"Park Ridge, IL"', add
label define city_lbl 5123 `"Parkersburg, WV"', add
label define city_lbl 5124 `"Parma, OH"', add
label define city_lbl 5125 `"Parsons, KS"', add
label define city_lbl 5130 `"Oxnard, CA"', add
label define city_lbl 5140 `"Palmdale, CA"', add
label define city_lbl 5150 `"Pasadena, CA"', add
label define city_lbl 5170 `"Pasadena, TX"', add
label define city_lbl 5180 `"Paducah, KY"', add
label define city_lbl 5190 `"Passaic, NJ"', add
label define city_lbl 5210 `"Paterson, NJ"', add
label define city_lbl 5230 `"Pawtucket, RI"', add
label define city_lbl 5231 `"Peabody, MA"', add
label define city_lbl 5232 `"Peekskill, NY"', add
label define city_lbl 5233 `"Pekin, IL"', add
label define city_lbl 5240 `"Pembroke Pines, FL"', add
label define city_lbl 5250 `"Pensacola, FL"', add
label define city_lbl 5255 `"Pensauken, NJ"', add
label define city_lbl 5269 `"Peoria, AZ"', add
label define city_lbl 5270 `"Peoria, IL"', add
label define city_lbl 5271 `"Peoria Heights, IL"', add
label define city_lbl 5290 `"Perth Amboy, NJ"', add
label define city_lbl 5291 `"Peru, IN"', add
label define city_lbl 5310 `"Petersburg, VA"', add
label define city_lbl 5311 `"Phenix City, AL"', add
label define city_lbl 5330 `"Philadelphia, PA"', add
label define city_lbl 5331 `"Kensington"', add
label define city_lbl 5332 `"Mayamensing"', add
label define city_lbl 5333 `"Northern Liberties"', add
label define city_lbl 5334 `"Southwark"', add
label define city_lbl 5335 `"Spring Garden"', add
label define city_lbl 5341 `"Phillipsburg, NJ"', add
label define city_lbl 5350 `"Phoenix, AZ"', add
label define city_lbl 5351 `"Phoenixville, PA"', add
label define city_lbl 5352 `"Pine Bluff, AR"', add
label define city_lbl 5353 `"Piqua, OH"', add
label define city_lbl 5354 `"Pittsburg, KS"', add
label define city_lbl 5370 `"Pittsburgh, PA"', add
label define city_lbl 5390 `"Pittsfield, MA"', add
label define city_lbl 5391 `"Pittston, PA"', add
label define city_lbl 5409 `"Plains, PA"', add
label define city_lbl 5410 `"Plainfield, NJ"', add
label define city_lbl 5411 `"Plattsburg, NY"', add
label define city_lbl 5412 `"Pleasantville, NJ"', add
label define city_lbl 5413 `"Plymouth, PA"', add
label define city_lbl 5414 `"Plymouth, MA"', add
label define city_lbl 5415 `"Pocatello, ID"', add
label define city_lbl 5430 `"Plano, TX"', add
label define city_lbl 5450 `"Pomona, CA"', add
label define city_lbl 5451 `"Ponca City, OK"', add
label define city_lbl 5460 `"Ponce, PR"', add
label define city_lbl 5470 `"Pontiac, MI"', add
label define city_lbl 5471 `"Port Angeles, WA"', add
label define city_lbl 5480 `"Port Arthur, TX"', add
label define city_lbl 5481 `"Port Chester, NY"', add
label define city_lbl 5490 `"Port Huron, MI"', add
label define city_lbl 5491 `"Port Jervis, NY"', add
label define city_lbl 5500 `"Port St. Lucie, FL"', add
label define city_lbl 5510 `"Portland, ME"', add
label define city_lbl 5511 `"Portland, IL"', add
label define city_lbl 5530 `"Portland, OR"', add
label define city_lbl 5550 `"Portsmouth, NH"', add
label define city_lbl 5570 `"Portsmouth, OH"', add
label define city_lbl 5590 `"Portsmouth, VA"', add
label define city_lbl 5591 `"Pottstown, PA"', add
label define city_lbl 5610 `"Pottsville, PA"', add
label define city_lbl 5630 `"Poughkeepsie, NY"', add
label define city_lbl 5650 `"Providence, RI"', add
label define city_lbl 5660 `"Provo, UT"', add
label define city_lbl 5670 `"Pueblo, CO"', add
label define city_lbl 5671 `"Punxsutawney, PA"', add
label define city_lbl 5690 `"Quincy, IL"', add
label define city_lbl 5710 `"Quincy, MA"', add
label define city_lbl 5730 `"Racine, WI"', add
label define city_lbl 5731 `"Rahway, NJ"', add
label define city_lbl 5750 `"Raleigh, NC"', add
label define city_lbl 5751 `"Ranger, TX"', add
label define city_lbl 5752 `"Rapid City, SD"', add
label define city_lbl 5770 `"Rancho Cucamonga, CA"', add
label define city_lbl 5790 `"Reading, PA"', add
label define city_lbl 5791 `"Red Bank, NJ"', add
label define city_lbl 5792 `"Redlands, CA"', add
label define city_lbl 5810 `"Reno, NV"', add
label define city_lbl 5811 `"Rensselaer, NY"', add
label define city_lbl 5830 `"Revere, MA"', add
label define city_lbl 5850 `"Richmond, IN"', add
label define city_lbl 5870 `"Richmond, VA"', add
label define city_lbl 5871 `"Richmond, CA"', add
label define city_lbl 5872 `"Ridgefield Park, NJ"', add
label define city_lbl 5873 `"Ridgewood, NJ"', add
label define city_lbl 5874 `"River Rouge, MI"', add
label define city_lbl 5890 `"Riverside, CA"', add
label define city_lbl 5910 `"Roanoke, VA"', add
label define city_lbl 5930 `"Rochester, NY"', add
label define city_lbl 5931 `"Rochester, NH"', add
label define city_lbl 5932 `"Rochester, MN"', add
label define city_lbl 5933 `"Rock Hill, SC"', add
label define city_lbl 5950 `"Rock Island, IL"', add
label define city_lbl 5970 `"Rockford, IL"', add
label define city_lbl 5971 `"Rockland, ME"', add
label define city_lbl 5972 `"Rockton, IL"', add
label define city_lbl 5973 `"Rockville Centre, NY"', add
label define city_lbl 5974 `"Rocky Mount, NC"', add
label define city_lbl 5990 `"Rome, NY"', add
label define city_lbl 5991 `"Rome, GA"', add
label define city_lbl 5992 `"Roosevelt, NJ"', add
label define city_lbl 5993 `"Roselle, NJ"', add
label define city_lbl 5994 `"Roswell, NM"', add
label define city_lbl 5995 `"Roseville, CA"', add
label define city_lbl 6010 `"Roxbury, MA"', add
label define city_lbl 6011 `"Royal Oak, MI"', add
label define city_lbl 6012 `"Rumford Falls, ME"', add
label define city_lbl 6013 `"Rutherford, NJ"', add
label define city_lbl 6014 `"Rutland, VT"', add
label define city_lbl 6030 `"Sacramento, CA"', add
label define city_lbl 6050 `"Saginaw, MI"', add
label define city_lbl 6070 `"Saint Joseph, MO"', add
label define city_lbl 6090 `"Saint Louis, MO"', add
label define city_lbl 6110 `"Saint Paul, MN"', add
label define city_lbl 6130 `"Saint Petersburg, FL"', add
label define city_lbl 6150 `"Salem, MA"', add
label define city_lbl 6170 `"Salem, OR"', add
label define city_lbl 6171 `"Salem, OH"', add
label define city_lbl 6172 `"Salina, KS"', add
label define city_lbl 6190 `"Salinas, CA"', add
label define city_lbl 6191 `"Salisbury, NC"', add
label define city_lbl 6192 `"Salisbury, MD"', add
label define city_lbl 6210 `"Salt Lake City, UT"', add
label define city_lbl 6211 `"San Angelo, TX"', add
label define city_lbl 6220 `"San Angelo, TX"', add
label define city_lbl 6230 `"San Antonio, TX"', add
label define city_lbl 6231 `"San Benito, TX"', add
label define city_lbl 6250 `"San Bernardino, CA"', add
label define city_lbl 6260 `"San Buenaventura (Ventura), CA"', add
label define city_lbl 6270 `"San Diego, CA"', add
label define city_lbl 6280 `"Sandusky, OH"', add
label define city_lbl 6281 `"Sanford, FL"', add
label define city_lbl 6282 `"Sanford, ME"', add
label define city_lbl 6290 `"San Francisco, CA"', add
label define city_lbl 6300 `"San Juan, PR"', add
label define city_lbl 6310 `"San Jose, CA"', add
label define city_lbl 6311 `"San Leandro, CA"', add
label define city_lbl 6312 `"San Mateo, CA"', add
label define city_lbl 6320 `"Santa Barbara, CA"', add
label define city_lbl 6321 `"Santa Cruz, CA"', add
label define city_lbl 6322 `"Santa Fe, NM"', add
label define city_lbl 6330 `"Santa Ana, CA"', add
label define city_lbl 6335 `"Santa Clara, CA"', add
label define city_lbl 6340 `"Santa Clarita, CA"', add
label define city_lbl 6350 `"Santa Rosa, CA"', add
label define city_lbl 6351 `"Sapulpa, OK"', add
label define city_lbl 6352 `"Saratoga Springs, NY"', add
label define city_lbl 6353 `"Saugus, MA"', add
label define city_lbl 6354 `"Sault Ste. Marie, MI"', add
label define city_lbl 6360 `"Santa Monica, CA"', add
label define city_lbl 6370 `"Savannah, GA"', add
label define city_lbl 6390 `"Schenectedy, NY"', add
label define city_lbl 6410 `"Scranton, PA"', add
label define city_lbl 6430 `"Seattle, WA"', add
label define city_lbl 6431 `"Sedalia, MO"', add
label define city_lbl 6432 `"Selma, AL"', add
label define city_lbl 6433 `"Seminole, OK"', add
label define city_lbl 6434 `"Shaker Heights, OH"', add
label define city_lbl 6435 `"Shamokin, PA"', add
label define city_lbl 6437 `"Sharpsville, PA"', add
label define city_lbl 6438 `"Shawnee, OK"', add
label define city_lbl 6440 `"Sharon, PA"', add
label define city_lbl 6450 `"Sheboygan, WI"', add
label define city_lbl 6451 `"Shelby, NC"', add
label define city_lbl 6452 `"Shelbyville, IN"', add
label define city_lbl 6453 `"Shelton, CT"', add
label define city_lbl 6470 `"Shenandoah Borough, PA"', add
label define city_lbl 6471 `"Sherman, TX"', add
label define city_lbl 6472 `"Shorewood, WI"', add
label define city_lbl 6490 `"Shreveport, LA"', add
label define city_lbl 6500 `"Simi Valley, CA"', add
label define city_lbl 6510 `"Sioux City, IA"', add
label define city_lbl 6530 `"Sioux Falls, SD"', add
label define city_lbl 6550 `"Smithfield, RI (1850)"', add
label define city_lbl 6570 `"Somerville, MA"', add
label define city_lbl 6590 `"South Bend, IN"', add
label define city_lbl 6591 `"South Bethlehem, PA"', add
label define city_lbl 6592 `"South Boise, ID"', add
label define city_lbl 6593 `"South Gate, CA"', add
label define city_lbl 6594 `"South Milwaukee, WI"', add
label define city_lbl 6595 `"South Norwalk, CT"', add
label define city_lbl 6610 `"South Omaha, NE"', add
label define city_lbl 6611 `"South Orange, NJ"', add
label define city_lbl 6612 `"South Pasadena, CA"', add
label define city_lbl 6613 `"South Pittsburgh, PA"', add
label define city_lbl 6614 `"South Portland, ME"', add
label define city_lbl 6615 `"South River, NJ"', add
label define city_lbl 6616 `"South St. Paul, MN"', add
label define city_lbl 6617 `"Southbridge, MA"', add
label define city_lbl 6620 `"Spartanburg, SC"', add
label define city_lbl 6630 `"Spokane, WA"', add
label define city_lbl 6640 `"Spring Valley, NV"', add
label define city_lbl 6650 `"Springfield, IL"', add
label define city_lbl 6670 `"Springfield, MA"', add
label define city_lbl 6690 `"Springfield, MO"', add
label define city_lbl 6691 `"St. Augustine, FL"', add
label define city_lbl 6692 `"St. Charles, MO"', add
label define city_lbl 6693 `"St. Cloud, MN"', add
label define city_lbl 6710 `"Springfield, OH"', add
label define city_lbl 6730 `"Stamford, CT"', add
label define city_lbl 6731 `"Statesville, NC"', add
label define city_lbl 6732 `"Staunton, VA"', add
label define city_lbl 6733 `"Steelton, PA"', add
label define city_lbl 6734 `"Sterling, IL"', add
label define city_lbl 6750 `"Sterling Heights, MI"', add
label define city_lbl 6770 `"Steubenville, OH"', add
label define city_lbl 6771 `"Stevens Point, WI"', add
label define city_lbl 6772 `"Stillwater, MN"', add
label define city_lbl 6789 `"Stowe, PA"', add
label define city_lbl 6790 `"Stockton, CA"', add
label define city_lbl 6791 `"Stoneham, MA"', add
label define city_lbl 6792 `"Stonington, CT"', add
label define city_lbl 6793 `"Stratford, CT"', add
label define city_lbl 6794 `"Streator, IL"', add
label define city_lbl 6795 `"Struthers, OH"', add
label define city_lbl 6796 `"Suffolk, VA"', add
label define city_lbl 6797 `"Summit, NJ"', add
label define city_lbl 6798 `"Sumter, SC"', add
label define city_lbl 6799 `"Sunbury, PA"', add
label define city_lbl 6810 `"Sunnyvale, CA"', add
label define city_lbl 6830 `"Superior, WI"', add
label define city_lbl 6831 `"Swampscott, MA"', add
label define city_lbl 6832 `"Sweetwater, TX"', add
label define city_lbl 6833 `"Swissvale, PA"', add
label define city_lbl 6850 `"Syracuse, NY"', add
label define city_lbl 6870 `"Tacoma, WA"', add
label define city_lbl 6871 `"Tallahassee, FL"', add
label define city_lbl 6872 `"Tamaqua, PA"', add
label define city_lbl 6890 `"Tampa, FL"', add
label define city_lbl 6910 `"Taunton, MA"', add
label define city_lbl 6911 `"Taylor, PA"', add
label define city_lbl 6912 `"Temple, TX"', add
label define city_lbl 6913 `"Teaneck, NJ"', add
label define city_lbl 6930 `"Tempe, AZ"', add
label define city_lbl 6950 `"Terre Haute, IN"', add
label define city_lbl 6951 `"Texarkana, TX"', add
label define city_lbl 6952 `"Thomasville, GA"', add
label define city_lbl 6953 `"Thomasville, NC"', add
label define city_lbl 6954 `"Tiffin, OH"', add
label define city_lbl 6960 `"Thousand Oaks, CA"', add
label define city_lbl 6970 `"Toledo, OH"', add
label define city_lbl 6971 `"Tonawanda, NY"', add
label define city_lbl 6990 `"Topeka, KS"', add
label define city_lbl 6991 `"Torrington, CT"', add
label define city_lbl 6992 `"Traverse City, MI"', add
label define city_lbl 7000 `"Torrance, CA"', add
label define city_lbl 7010 `"Trenton, NJ"', add
label define city_lbl 7011 `"Trinidad, CO"', add
label define city_lbl 7030 `"Troy, NY"', add
label define city_lbl 7050 `"Tucson, AZ"', add
label define city_lbl 7070 `"Tulsa, OK"', add
label define city_lbl 7071 `"Turtle Creek, PA"', add
label define city_lbl 7072 `"Tuscaloosa, AL"', add
label define city_lbl 7073 `"Two Rivers, WI"', add
label define city_lbl 7074 `"Tyler, TX"', add
label define city_lbl 7079 `"Union, NJ"', add
label define city_lbl 7080 `"Union City, NJ"', add
label define city_lbl 7081 `"Uniontown, PA"', add
label define city_lbl 7082 `"University City, MO"', add
label define city_lbl 7083 `"Urbana, IL"', add
label define city_lbl 7084 `"Upper Darby, PA"', add
label define city_lbl 7090 `"Utica, NY"', add
label define city_lbl 7091 `"Valdosta, GA"', add
label define city_lbl 7092 `"Vallejo, CA"', add
label define city_lbl 7093 `"Valley Stream, NY"', add
label define city_lbl 7100 `"Vancouver, WA"', add
label define city_lbl 7110 `"Vallejo, CA"', add
label define city_lbl 7111 `"Vandergrift, PA"', add
label define city_lbl 7112 `"Venice, CA"', add
label define city_lbl 7120 `"Vicksburg, MS"', add
label define city_lbl 7121 `"Vincennes, IN"', add
label define city_lbl 7122 `"Virginia, MN"', add
label define city_lbl 7123 `"Virginia City, NV"', add
label define city_lbl 7130 `"Virginia Beach, VA"', add
label define city_lbl 7140 `"Visalia, CA"', add
label define city_lbl 7150 `"Waco, TX"', add
label define city_lbl 7151 `"Wakefield, MA"', add
label define city_lbl 7152 `"Walla Walla, WA"', add
label define city_lbl 7153 `"Wallingford, CT"', add
label define city_lbl 7170 `"Waltham, MA"', add
label define city_lbl 7180 `"Warren, MI"', add
label define city_lbl 7190 `"Warren, OH"', add
label define city_lbl 7191 `"Warren, PA"', add
label define city_lbl 7210 `"Warwick Town, RI"', add
label define city_lbl 7230 `"Washington, DC"', add
label define city_lbl 7231 `"Georgetown, DC"', add
label define city_lbl 7241 `"Washington, PA"', add
label define city_lbl 7242 `"Washington, VA"', add
label define city_lbl 7250 `"Waterbury, CT"', add
label define city_lbl 7270 `"Waterloo, IA"', add
label define city_lbl 7290 `"Waterloo, NY"', add
label define city_lbl 7310 `"Watertown, NY"', add
label define city_lbl 7311 `"Watertown, WI"', add
label define city_lbl 7312 `"Watertown, SD"', add
label define city_lbl 7313 `"Watertown, MA"', add
label define city_lbl 7314 `"Waterville, ME"', add
label define city_lbl 7315 `"Watervliet, NY"', add
label define city_lbl 7316 `"Waukegan, IL"', add
label define city_lbl 7317 `"Waukesha, WI"', add
label define city_lbl 7318 `"Wausau, WI"', add
label define city_lbl 7319 `"Wauwatosa, WI"', add
label define city_lbl 7320 `"West Covina, CA"', add
label define city_lbl 7321 `"Waycross, GA"', add
label define city_lbl 7322 `"Waynesboro, PA"', add
label define city_lbl 7323 `"Webb City, MO"', add
label define city_lbl 7324 `"Webster Groves, MO"', add
label define city_lbl 7325 `"Webster, MA"', add
label define city_lbl 7326 `"Wellesley, MA"', add
label define city_lbl 7327 `"Wenatchee, WA"', add
label define city_lbl 7328 `"Weehawken, NJ"', add
label define city_lbl 7329 `"West Bay City, MI"', add
label define city_lbl 7330 `"West Hoboken, NJ"', add
label define city_lbl 7331 `"West Bethlehem, PA"', add
label define city_lbl 7332 `"West Chester, PA"', add
label define city_lbl 7333 `"West Frankfort, IL"', add
label define city_lbl 7334 `"West Hartford, CT"', add
label define city_lbl 7335 `"West Haven, CT"', add
label define city_lbl 7340 `"West Allis, WI"', add
label define city_lbl 7350 `"West New York, NJ"', add
label define city_lbl 7351 `"West Orange, NJ"', add
label define city_lbl 7352 `"West Palm Beach, FL"', add
label define city_lbl 7353 `"West Springfield, MA"', add
label define city_lbl 7370 `"West Troy, NY"', add
label define city_lbl 7371 `"West Warwick, RI"', add
label define city_lbl 7372 `"Westbrook, ME"', add
label define city_lbl 7373 `"Westerly, RI"', add
label define city_lbl 7374 `"Westfield, MA"', add
label define city_lbl 7375 `"Westfield, NJ"', add
label define city_lbl 7376 `"Wewoka, OK"', add
label define city_lbl 7377 `"Weymouth, MA"', add
label define city_lbl 7390 `"Wheeling, WV"', add
label define city_lbl 7400 `"White Plains, NY"', add
label define city_lbl 7401 `"Whiting, IN"', add
label define city_lbl 7402 `"Whittier, CA"', add
label define city_lbl 7410 `"Wichita, KS"', add
label define city_lbl 7430 `"Wichita Falls, TX"', add
label define city_lbl 7450 `"Wilkes-Barre, PA"', add
label define city_lbl 7451 `"Wilkinsburg, PA"', add
label define city_lbl 7460 `"Wilkinsburg, PA"', add
label define city_lbl 7470 `"Williamsport, PA"', add
label define city_lbl 7471 `"Willimantic, CT"', add
label define city_lbl 7472 `"Wilmette, IL"', add
label define city_lbl 7490 `"Wilmington, DE"', add
label define city_lbl 7510 `"Wilmington, NC"', add
label define city_lbl 7511 `"Wilson, NC"', add
label define city_lbl 7512 `"Winchester, VA"', add
label define city_lbl 7513 `"Winchester, MA"', add
label define city_lbl 7514 `"Windham, CT"', add
label define city_lbl 7515 `"Winnetka, IL"', add
label define city_lbl 7516 `"Winona, MN"', add
label define city_lbl 7530 `"Winston-Salem, NC"', add
label define city_lbl 7531 `"Winthrop, MA"', add
label define city_lbl 7532 `"Woburn, MA"', add
label define city_lbl 7533 `"Woodlawn, PA"', add
label define city_lbl 7534 `"Woodmont, CT"', add
label define city_lbl 7535 `"Woodbridge, NJ"', add
label define city_lbl 7550 `"Woonsocket, RI"', add
label define city_lbl 7551 `"Wooster, OH"', add
label define city_lbl 7570 `"Worcester, MA"', add
label define city_lbl 7571 `"Wyandotte, MI"', add
label define city_lbl 7572 `"Xenia, OH"', add
label define city_lbl 7573 `"Yakima, WA"', add
label define city_lbl 7590 `"Yonkers, NY"', add
label define city_lbl 7610 `"York, PA"', add
label define city_lbl 7630 `"Youngstown, OH"', add
label define city_lbl 7631 `"Ypsilanti, MI"', add
label define city_lbl 7650 `"Zanesville, OH"', add
label values city city_lbl

label define gq_lbl 0 `"Vacant unit"'
label define gq_lbl 1 `"Households under 1970 definition"', add
label define gq_lbl 2 `"Additional households under 1990 definition"', add
label define gq_lbl 3 `"Group quarters--Institutions"', add
label define gq_lbl 4 `"Other group quarters"', add
label define gq_lbl 5 `"Additional households under 2000 definition"', add
label define gq_lbl 6 `"Fragment"', add
label values gq gq_lbl

label define sex_lbl 1 `"Male"'
label define sex_lbl 2 `"Female"', add
label values sex sex_lbl

label define age_lbl 000 `"Less than 1 year old"'
label define age_lbl 001 `"1"', add
label define age_lbl 002 `"2"', add
label define age_lbl 003 `"3"', add
label define age_lbl 004 `"4"', add
label define age_lbl 005 `"5"', add
label define age_lbl 006 `"6"', add
label define age_lbl 007 `"7"', add
label define age_lbl 008 `"8"', add
label define age_lbl 009 `"9"', add
label define age_lbl 010 `"10"', add
label define age_lbl 011 `"11"', add
label define age_lbl 012 `"12"', add
label define age_lbl 013 `"13"', add
label define age_lbl 014 `"14"', add
label define age_lbl 015 `"15"', add
label define age_lbl 016 `"16"', add
label define age_lbl 017 `"17"', add
label define age_lbl 018 `"18"', add
label define age_lbl 019 `"19"', add
label define age_lbl 020 `"20"', add
label define age_lbl 021 `"21"', add
label define age_lbl 022 `"22"', add
label define age_lbl 023 `"23"', add
label define age_lbl 024 `"24"', add
label define age_lbl 025 `"25"', add
label define age_lbl 026 `"26"', add
label define age_lbl 027 `"27"', add
label define age_lbl 028 `"28"', add
label define age_lbl 029 `"29"', add
label define age_lbl 030 `"30"', add
label define age_lbl 031 `"31"', add
label define age_lbl 032 `"32"', add
label define age_lbl 033 `"33"', add
label define age_lbl 034 `"34"', add
label define age_lbl 035 `"35"', add
label define age_lbl 036 `"36"', add
label define age_lbl 037 `"37"', add
label define age_lbl 038 `"38"', add
label define age_lbl 039 `"39"', add
label define age_lbl 040 `"40"', add
label define age_lbl 041 `"41"', add
label define age_lbl 042 `"42"', add
label define age_lbl 043 `"43"', add
label define age_lbl 044 `"44"', add
label define age_lbl 045 `"45"', add
label define age_lbl 046 `"46"', add
label define age_lbl 047 `"47"', add
label define age_lbl 048 `"48"', add
label define age_lbl 049 `"49"', add
label define age_lbl 050 `"50"', add
label define age_lbl 051 `"51"', add
label define age_lbl 052 `"52"', add
label define age_lbl 053 `"53"', add
label define age_lbl 054 `"54"', add
label define age_lbl 055 `"55"', add
label define age_lbl 056 `"56"', add
label define age_lbl 057 `"57"', add
label define age_lbl 058 `"58"', add
label define age_lbl 059 `"59"', add
label define age_lbl 060 `"60"', add
label define age_lbl 061 `"61"', add
label define age_lbl 062 `"62"', add
label define age_lbl 063 `"63"', add
label define age_lbl 064 `"64"', add
label define age_lbl 065 `"65"', add
label define age_lbl 066 `"66"', add
label define age_lbl 067 `"67"', add
label define age_lbl 068 `"68"', add
label define age_lbl 069 `"69"', add
label define age_lbl 070 `"70"', add
label define age_lbl 071 `"71"', add
label define age_lbl 072 `"72"', add
label define age_lbl 073 `"73"', add
label define age_lbl 074 `"74"', add
label define age_lbl 075 `"75"', add
label define age_lbl 076 `"76"', add
label define age_lbl 077 `"77"', add
label define age_lbl 078 `"78"', add
label define age_lbl 079 `"79"', add
label define age_lbl 080 `"80"', add
label define age_lbl 081 `"81"', add
label define age_lbl 082 `"82"', add
label define age_lbl 083 `"83"', add
label define age_lbl 084 `"84"', add
label define age_lbl 085 `"85"', add
label define age_lbl 086 `"86"', add
label define age_lbl 087 `"87"', add
label define age_lbl 088 `"88"', add
label define age_lbl 089 `"89"', add
label define age_lbl 090 `"90 (90+ in 1980 and 1990)"', add
label define age_lbl 091 `"91"', add
label define age_lbl 092 `"92"', add
label define age_lbl 093 `"93"', add
label define age_lbl 094 `"94"', add
label define age_lbl 095 `"95"', add
label define age_lbl 096 `"96"', add
label define age_lbl 097 `"97"', add
label define age_lbl 098 `"98"', add
label define age_lbl 099 `"99"', add
label define age_lbl 100 `"100 (100+ in 1960-1970)"', add
label define age_lbl 101 `"101"', add
label define age_lbl 102 `"102"', add
label define age_lbl 103 `"103"', add
label define age_lbl 104 `"104"', add
label define age_lbl 105 `"105"', add
label define age_lbl 106 `"106"', add
label define age_lbl 107 `"107"', add
label define age_lbl 108 `"108"', add
label define age_lbl 109 `"109"', add
label define age_lbl 110 `"110"', add
label define age_lbl 111 `"111"', add
label define age_lbl 112 `"112 (112+ in the 1980 internal data)"', add
label define age_lbl 113 `"113"', add
label define age_lbl 114 `"114"', add
label define age_lbl 115 `"115 (115+ in the 1990 internal data)"', add
label define age_lbl 116 `"116"', add
label define age_lbl 117 `"117"', add
label define age_lbl 118 `"118"', add
label define age_lbl 119 `"119"', add
label define age_lbl 120 `"120"', add
label define age_lbl 121 `"121"', add
label define age_lbl 122 `"122"', add
label define age_lbl 123 `"123"', add
label define age_lbl 124 `"124"', add
label define age_lbl 125 `"125"', add
label define age_lbl 126 `"126"', add
label define age_lbl 129 `"129"', add
label define age_lbl 130 `"130"', add
label define age_lbl 135 `"135"', add
label values age age_lbl

label define school_lbl 0 `"N/A"'
label define school_lbl 1 `"No, not in school"', add
label define school_lbl 2 `"Yes, in school"', add
label define school_lbl 9 `"Missing"', add
label values school school_lbl

label define educ_lbl 00 `"N/A or no schooling"'
label define educ_lbl 01 `"Nursery school to grade 4"', add
label define educ_lbl 02 `"Grade 5, 6, 7, or 8"', add
label define educ_lbl 03 `"Grade 9"', add
label define educ_lbl 04 `"Grade 10"', add
label define educ_lbl 05 `"Grade 11"', add
label define educ_lbl 06 `"Grade 12"', add
label define educ_lbl 07 `"1 year of college"', add
label define educ_lbl 08 `"2 years of college"', add
label define educ_lbl 09 `"3 years of college"', add
label define educ_lbl 10 `"4 years of college"', add
label define educ_lbl 11 `"5+ years of college"', add
label values educ educ_lbl

label define educd_lbl 000 `"N/A or no schooling"'
label define educd_lbl 001 `"N/A"', add
label define educd_lbl 002 `"No schooling completed"', add
label define educd_lbl 010 `"Nursery school to grade 4"', add
label define educd_lbl 011 `"Nursery school, preschool"', add
label define educd_lbl 012 `"Kindergarten"', add
label define educd_lbl 013 `"Grade 1, 2, 3, or 4"', add
label define educd_lbl 014 `"Grade 1"', add
label define educd_lbl 015 `"Grade 2"', add
label define educd_lbl 016 `"Grade 3"', add
label define educd_lbl 017 `"Grade 4"', add
label define educd_lbl 020 `"Grade 5, 6, 7, or 8"', add
label define educd_lbl 021 `"Grade 5 or 6"', add
label define educd_lbl 022 `"Grade 5"', add
label define educd_lbl 023 `"Grade 6"', add
label define educd_lbl 024 `"Grade 7 or 8"', add
label define educd_lbl 025 `"Grade 7"', add
label define educd_lbl 026 `"Grade 8"', add
label define educd_lbl 030 `"Grade 9"', add
label define educd_lbl 040 `"Grade 10"', add
label define educd_lbl 050 `"Grade 11"', add
label define educd_lbl 060 `"Grade 12"', add
label define educd_lbl 061 `"12th grade, no diploma"', add
label define educd_lbl 062 `"High school graduate or GED"', add
label define educd_lbl 063 `"Regular high school diploma"', add
label define educd_lbl 064 `"GED or alternative credential"', add
label define educd_lbl 065 `"Some college, but less than 1 year"', add
label define educd_lbl 070 `"1 year of college"', add
label define educd_lbl 071 `"1 or more years of college credit, no degree"', add
label define educd_lbl 080 `"2 years of college"', add
label define educd_lbl 081 `"Associate's degree, type not specified"', add
label define educd_lbl 082 `"Associate's degree, occupational program"', add
label define educd_lbl 083 `"Associate's degree, academic program"', add
label define educd_lbl 090 `"3 years of college"', add
label define educd_lbl 100 `"4 years of college"', add
label define educd_lbl 101 `"Bachelor's degree"', add
label define educd_lbl 110 `"5+ years of college"', add
label define educd_lbl 111 `"6 years of college (6+ in 1960-1970)"', add
label define educd_lbl 112 `"7 years of college"', add
label define educd_lbl 113 `"8+ years of college"', add
label define educd_lbl 114 `"Master's degree"', add
label define educd_lbl 115 `"Professional degree beyond a bachelor's degree"', add
label define educd_lbl 116 `"Doctoral degree"', add
label define educd_lbl 999 `"Missing"', add
label values educd educd_lbl

label define empstat_lbl 0 `"N/A"'
label define empstat_lbl 1 `"Employed"', add
label define empstat_lbl 2 `"Unemployed"', add
label define empstat_lbl 3 `"Not in labor force"', add
label values empstat empstat_lbl

label define empstatd_lbl 00 `"N/A"'
label define empstatd_lbl 10 `"At work"', add
label define empstatd_lbl 11 `"At work, public emerg"', add
label define empstatd_lbl 12 `"Has job, not working"', add
label define empstatd_lbl 13 `"Armed forces"', add
label define empstatd_lbl 14 `"Armed forces--at work"', add
label define empstatd_lbl 15 `"Armed forces--not at work but with job"', add
label define empstatd_lbl 20 `"Unemployed"', add
label define empstatd_lbl 21 `"Unemp, exper worker"', add
label define empstatd_lbl 22 `"Unemp, new worker"', add
label define empstatd_lbl 30 `"Not in Labor Force"', add
label define empstatd_lbl 31 `"NILF, housework"', add
label define empstatd_lbl 32 `"NILF, unable to work"', add
label define empstatd_lbl 33 `"NILF, school"', add
label define empstatd_lbl 34 `"NILF, other"', add
label values empstatd empstatd_lbl

label define labforce_lbl 0 `"N/A"'
label define labforce_lbl 1 `"No, not in the labor force"', add
label define labforce_lbl 2 `"Yes, in the labor force"', add
label values labforce labforce_lbl


