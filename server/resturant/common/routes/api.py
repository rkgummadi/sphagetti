from asyncio import gather
import json

from sqlalchemy.orm import session
from resturant.common.json import jsonify
from resturant.common.utilities import camelcase_recurse
from pathlib import Path
from aiohttp.web import Response, get, post

import logging
logger = logging.getLogger('resturant.common.routes.api')


def register_routes(app):
    app.add_routes([

    get('/api/me', get_user_role),
    get('/api/getmenu', get_menu),
    get('/api/getschedulemenu', get_schedule_menu),
    get('/api/gettodaymenu', get_today_menu),


    post('/api/getmenubyday', get_menu_byday),
    post('/api/updatemenu', update_menu),
    post('/api/insertmenu', insert_menu),    
    post('/api/insertschedule', insert_schedule),

    ])

    

async def get_user_role(request):
    try:

        user=request.app['userrole']

        return jsonify({
            'user': user
        })
    except Exception as e:
        print(e)
        logger.exception(f"Error while get_feature_access : {e}")
        raise
async def get_today_menu(request):
    try:
        
        repo = request.app['resturantcommondb']
        menu_items = await repo.get_today_menu()
        
        return jsonify({
            'menu_items': menu_items
        })        
    except Exception as e:
        print(e)
        logger.exception(f"Error while get_feature_access : {e}")
        raise

async def get_schedule_menu(request):
    try:
        
        repo = request.app['resturantcommondb']
        menu_items = await repo.Get_Schedule_Menu()

        return jsonify({
            'menu_items': menu_items
        })
    except Exception as e:
        print(e)
        logger.exception(f"Error while get_feature_access : {e}")
        raise


async def get_menu(request):
    try:
        
        repo = request.app['resturantcommondb']
        menu_items = await repo.Get_Menu_items()

        return jsonify({
            'menu_items': menu_items
        })
    except Exception as e:
        print(e)
        logger.exception(f"Error while get_feature_access : {e}")
        raise


async def get_menu_byday(request):
    try:
        day=request.get('day',1)
       
        repo = request.app['resturantcommondb']
        menu_byweekday = await repo.get_menu_byday(day)
        return jsonify({
            'menu_byweekday': menu_byweekday
        })
    except Exception as e:
        logger.exception(f"Error while get_all_roles : {e}")
        raise

async def update_menu(request):

    
    try:
       
        data = await request.json()

        repo = request.app['resturantcommondb']
        await repo.update_menu(data.get('data'))
        return jsonify('SUCCESS')

       
    except Exception as e:
        logger.exception(f"Error while update_feature_decision : {e}")
        raise

async def insert_menu(request):

    
    try:
       
        data = await request.json()

        repo = request.app['resturantcommondb']
        await repo.insert_menu(data['data'])
        return jsonify('SUCCESS')

       
    except Exception as e:
        logger.exception(f"Error while update_feature_decision : {e}")
        raise

async def insert_schedule(request):

    
    try:
       
        data = await request.json()

        repo = request.app['resturantcommondb']
        scheduleData = (data.get('updateData'))
       
        #print('rk',[(g['MenuID'],g['CategoryID'],g['WeekId']) for g in scheduleData])
        await repo.insert_schedule(scheduleData)
        return jsonify('SUCCESS')

       
    except Exception as e:
        print(e)
        #logger.exception(f"Error while update_feature_decision : {e}")
        raise
