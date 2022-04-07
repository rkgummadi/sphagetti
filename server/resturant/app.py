#import sentry_sdk
from aiohttp.web import Application
import asyncio
from dotenv import find_dotenv, load_dotenv
from sqlalchemy import text
from jinja2 import Environment, FileSystemLoader

from envbash import load_envbash
from cryptography.fernet import Fernet
import os
from sqlalchemy.engine.url import URL
from resturant import __version__
from resturant.config import AppConfig

from resturant.common.routes.api import register_routes as register_common_api_routes
from resturant.common.repos.asyncsysdb import resturantDatabaseRepo as CommonresturantDatabaseRepo


def create_app():

    dotenv = find_dotenv()
    if dotenv:
        print(f"Found .env file: {dotenv}")
        load_dotenv(dotenv)  # if any issues, add ",verbose=True"
    


 

    config = AppConfig()

    client_jinja_loader = FileSystemLoader(str(config.client_dir))
    client_jinja_env = Environment(
        loader=client_jinja_loader,
        variable_start_string=config.client_template_variable_start,
        variable_end_string=config.client_template_variable_end
    )
    jinja_env = Environment(
        loader = FileSystemLoader ( str(config.template_dir) )
    )
    
    def create_db_urls(config):
        config.resturantdb_url = URL(
            drivername=config.resturantdb_driver_name,
            host=config.resturantdb_host,
            port=config.resturantdb_port,
            username=config.resturantdb_username,
            password=config.resturantdb_password,
            database=config.resturantdb_database_name
        )

        return config

    if config.env == 'local':
        from aiohttp_middlewares import cors_middleware
        create_db_urls(config)

        middlewares = [
            cors_middleware(allow_all=True),

        ]

    app = Application(middlewares=middlewares, client_max_size=5242880)
    resturantCommonDb = CommonresturantDatabaseRepo(config.resturantdb_url, config)
    app['resturantcommondb'] = resturantCommonDb
    app['userrole']=config.resturantdb_role_name
    app['clientenv'] = client_jinja_env
    app['jinja_env'] = jinja_env



    register_common_api_routes(app)

    return app
