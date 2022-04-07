from asyncio import get_event_loop
from concurrent.futures import ThreadPoolExecutor
from functools import partial

from sqlalchemy import create_engine
from sqlalchemy.orm import create_session
from sqlalchemy.exc import SQLAlchemyError

from logging import getLogger
logger = getLogger('resturant.db.handler')

class Database:
    engines = {}

    def __init__(self, url, config, executor=None, loop=None,  **kwargs):
        #Reuse existing engines
        if url in self.engines.keys():
            self.engine = self.engines[url]
        else:
            self.engines[url] = self.engine = create_engine(url, pool_size=config.db_pool_size,pool_recycle = config.db_pool_recycle, pool_use_lifo=config.db_pool_use_lifo,  **kwargs)

        #Limit thread pool count
        self.executor = executor or ThreadPoolExecutor(config.db_thread_pool_count)
        self.loop = loop or get_event_loop()

    def execute(self, operation, *args, **kwargs):
        return self.run(self._execute, operation, *args, **kwargs)

    def run(self, func, *args, **kwargs):
        p = partial(func, self.engine, *args, **kwargs)
        return self.loop.run_in_executor(self.executor, p)

    def _execute(self, engine, operation, *args, **kwargs):
        try:
            logger.debug(operation)
            result = engine.execute(operation, *args, **kwargs)
            return ResultSet([row for row in result])
        except SQLAlchemyError as e:
            logger.error(f'SQLAlchemyError in Database._execute - {e}') 
            raise
        except:
            logger.exception("exception in Database._execute")
            raise

        

class ResultSet:

    def __init__(self, rows):
        self._rows = rows

    def all(self, as_dict=False):
        if as_dict:
            return self.as_dict()
        else:
            return self._rows

    def first(self, default=None, as_dict=False):
        if len(self._rows) == 0:
            return default
        if as_dict:
            return {key: value for key, value in self._rows[0].items()}
        else:
            return self._rows[0]

    def one(self, default=None, as_dict=False):
        if len(self) > 1:
            raise ValueError('More than one row in result set')
        return self.first(default, as_dict)

    def scalar(self, default=None):
        if len(self._rows) == 0:
            return default
        return self.one()[0]

    def as_dict(self):
        return [{key: value for key, value in row.items()} for row in self]

    def __iter__(self):
        return iter(self._rows)

    def __len__(self):
        return len(self._rows)
