from multiprocessing import cpu_count
from pathlib import Path
from typing import Optional, List, Dict

from pydantic import BaseSettings

from resturant import __version__


class GunicornConfig(BaseSettings):

    accesslog: str = None
    bind: str = '127.0.0.1:9000'
    keepalive: int = 2
    proc_name: str = 'resturant'
    reload: bool = False
    threads: int = 1
    timeout: int = 30
    worker_class: str = 'aiohttp.worker.GunicornWebWorker'
    workers: int = cpu_count()

    class Config:
        env_prefix = 'GUNICORN_'


class AppConfig(BaseSettings):

    class Config:
        env_prefix = 'app_'  # defaults to ""

    host: str = '127.0.0.1'
    port: int = 9000

    auth_enabled: bool = True

    auth_user_header: str = 'X-Authenticated-Client'
    auth_user_id_header: str = 'UserId'

    auth_set_user: Optional[str] = ''

    auth_group_header: str = 'X-Authenticated-Client-Group'

    auth_set_group: Optional[str] = 'customer'

  
    auth_fn_header: str = 'X-Authenticated-Client-First'
    auth_set_fn: Optional[str] = "FNtest"

    auth_ln_header: str = 'X-Authenticated-Client-Last'
    auth_set_ln: Optional[str] = "LNtest"

    auth_domain_header: str = 'X-Authenticated-Client-DN'
    auth_set_domain: Optional[str] = 'intusurg.com'
   

    client_dir: Path = Path(__file__).parent / 'client'
    client_template_variable_start: str = '{{'
    client_template_variable_end: str = '}}'

    
    search_data_cache_refresh: int = 7200
    resturantdb_url: str = None
    db_pool_size: int = 1
    db_pool_recycle: int = 3600
    db_pool_use_lifo: bool = False
    db_thread_pool_count: int = 1

  

    env: str = 'dev'

    var_key_list: List[str] = []

    resturantdb_driver_name: str
    resturantdb_host: str
    resturantdb_port: int
    resturantdb_username: str
    resturantdb_password: str
    resturantdb_database_name: str
    resturantdb_role_name:str


    version: str

    enable_referer: bool
    enable_empty_referer_cross_site_exception: bool
    allowed_hosts: list
    is_detailed_error_displayed: Optional[bool] = False
    template_dir: Path = Path(__file__).parent / 'common' / 'templates'

