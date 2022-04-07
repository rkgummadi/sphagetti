import logging
from multiprocessing import cpu_count
from os import environ

from resturant.config import GunicornConfig

for key, value in GunicornConfig():
    globals()[key] = value

'''
logconfig_dict = {
    'version': 1,
    'formatters': {
        'stdout': {
            'format': '[%(process)s][%(name)s][%(levelname)s] %(message)s',
            'datefmt': '%Y-%m-%d %H:%M:%S %z',
            'class': 'logging.Formatter'
        },
        'logfile': {
            'format': '[%(asctime)s][%(process)s][%(name)s][%(levelname)s] %(message)s',
            'datefmt': '%Y-%m-%d %H:%M:%S %z',
            'class': 'logging.Formatter'
        }
    },
    'handlers': {
        'stdout': {
            'class': 'logging.StreamHandler',
            'formatter': 'stdout',
            'level': logging.INFO,
        },
        'logfile': {
            'class': 'logging.handlers.TimedRotatingFileHandler',
            'formatter': 'logfile',
            'level': logging.INFO,
            'filename': environ['APP_LOG_FILE'],
            'when': 'D',
            'backupCount': 0
        }
    },
    'loggers': {
        'gunicorn.error': {
            'handlers': ['stdout', 'logfile'],
            'level': logging.INFO
        }
    },
    'root': {
        'handlers': ['stdout', 'logfile'],
        'level': logging.INFO
    }
}
'''