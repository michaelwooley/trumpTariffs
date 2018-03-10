import numpy as np


def getRecodes():
  return {
    'sex': {
      'sex': {
        1: 'Male',
        2: 'Female',
        9: -1
      }
    },
    'nwlookwk2':
      {
        'nwlookwk2':
          {
            0: 'None (not looking for work)',
            10: '1 to 4 weeks looking',
            20: '5 to 14 weeks looking',
            30: '15 to 26 weeks looking',
            40: '27 to 39 weeks looking',
            41: 'Over 26 weeks (1962-1967)',
            50: '40 or more weeks looking',
            99: -1
          }
      },
    'empstat':
      {
        'empstat_r1':
          {
            0: -1,
            1: 'At work',
            10: 'At work',
            12: 'At work',
            20: 'Unemployed',
            21: 'Unemployed',
            22: 'Unemployed',
            30: 'Not in labor force',
            31: 'Not in labor force',
            32: 'Not in labor force',
            33: 'Not in labor force',
            34: 'Not in labor force',
            35: 'Not in labor force',
            36: 'Not in labor force'
          },
        'empstat':
          {
            0: -1,
            1: 'Armed Forces',
            10: 'At work',
            12: 'Has job, not at work last week',
            20: 'Unemployed',
            21: 'Unemployed, experienced worker',
            22: 'Unemployed, new worker',
            30: 'Not in labor force',
            31: 'NILF, housework',
            32: 'NILF, unable to work',
            33: 'NILF, school',
            34: 'NILF, other',
            35: 'NILF, unpaid, lt 15 hours',
            36: 'NILF, retired'
          }
      },
    'labforce':
      {
        'labforce':
          {
            0: -1,
            1: 'No, not in the labor force',
            2: 'Yes, in the labor force'
          }
      },
    'educ':
      {
        'educ_r1':
          {
            0: -1,
            1: -1,
            2: 'High School Incomplete',
            10: 'High School Incomplete',
            11: 'High School Incomplete',
            12: 'High School Incomplete',
            13: 'High School Incomplete',
            14: 'High School Incomplete',
            20: 'High School Incomplete',
            21: 'High School Incomplete',
            22: 'High School Incomplete',
            30: 'High School Incomplete',
            31: 'High School Incomplete',
            32: 'High School Incomplete',
            40: 'High School Incomplete',
            50: 'High School Incomplete',
            60: 'High School Incomplete',
            70: 'High School Incomplete',
            71: 'High School Incomplete',
            72: 'High School Incomplete',
            73: 'HS Diploma',
            80: 'Some College',
            81: 'Some College',
            90: 'Some College',
            91: 'Some College',
            92: 'Some College',
            100: 'Some College',
            110: 'Some College',
            111: "Bachelor's Degree",
            120: 'Some Grad',
            121: 'Some Grad',
            122: 'Some Grad',
            123: "Master's",
            124: 'Professional',
            125: 'Doctorate',
            999: -1
          },
        'educ_r2':
          {
            0: -1,
            1: -1,
            2: 'High School Incomplete',
            10: 'High School Incomplete',
            11: 'High School Incomplete',
            12: 'High School Incomplete',
            13: 'High School Incomplete',
            14: 'High School Incomplete',
            20: 'High School Incomplete',
            21: 'High School Incomplete',
            22: 'High School Incomplete',
            30: 'High School Incomplete',
            31: 'High School Incomplete',
            32: 'High School Incomplete',
            40: 'High School Incomplete',
            50: 'High School Incomplete',
            60: 'High School Incomplete',
            70: 'High School Incomplete',
            71: 'High School Incomplete',
            72: 'High School Incomplete',
            73: 'HS Diploma',
            80: 'HS Diploma',
            81: 'HS Diploma',
            90: 'HS Diploma',
            91: 'HS Diploma',
            92: 'HS Diploma',
            100: 'HS Diploma',
            110: 'HS Diploma',
            111: "Bachelor's Degree",
            120: "Bachelor's Degree",
            121: 'Bachelor\'s Degree',
            122: 'Bachelor\'s Degree',
            123: "Graduate Degree",
            124: 'Graduate Degree',
            125: 'Graduate Degree',
            999: -1
          }
      },
    'race':
      {
        'race_r1':
          {
            100: 'White',
            200: 'Black',
            300: 'Other',
            650: 'Other',
            651: 'Asian',
            652: 'Other',
            700: 'Other',
            801: 'Multiple',
            802: 'Multiple',
            803: 'Multiple',
            804: 'Multiple',
            805: 'Multiple',
            806: 'Multiple',
            807: 'Multiple',
            808: 'Multiple',
            809: 'Multiple',
            810: 'Multiple',
            811: 'Multiple',
            812: 'Multiple',
            813: 'Multiple',
            814: 'Multiple',
            815: 'Multiple',
            816: 'Multiple',
            817: 'Multiple',
            818: 'Multiple',
            819: 'Multiple',
            820: 'Multiple',
            830: 'Multiple',
            999: 'Multiple'
          }
      },
    'vetstat': {
      'vetstat': {
        0: -1,
        1: 'No service',
        2: 'Yes',
        9: -1
      }
    },
    'sex': {
      'sex': {
        1: 'Male',
        2: 'Female',
        9: -1
      }
    },
    'migrate1':
      {
        'migrate1':
          {
            0: -1,
            1: 'No',
            2: 'Yes',
            3: 'No',
            4: 'Yes',
            5: 'Yes',
            6: 'Yes',
            9: -1
          }
      }
  }
