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


# async def get_ccm_errors(request):
#     try:
#         repo = request.app['resturantcommondb']
#         ccm_errors = await repo.get_ccm_errors()
#         return jsonify({
#             'ccmErrors': ccm_errors
#         })
#     except Exception as e:
#         logger.exception(f"Error while get_ccm_errors : {e}")
#         raise


# async def get_all_features(request):
#     try:
#         repo = request.app['resturantcommondb']
#         all_features = await repo.get_all_features()

#         return jsonify({
#             'features': all_features
#         })
#     except Exception as e:
#         logger.exception(f"Error while get_all_features : {e}")
#         raise


# async def get_all_features_roles_matrix(request):
#     try:
#         repo = request.app['resturantcommondb']
#         all_features_roles = await repo.get_all_features_roles_matrix()
#         return jsonify({
#             'features_roles_matrix': all_features_roles
#         })
#     except Exception as e:
#         logger.exception(f"Error while get_all_features_roles_matrix : {e}")
#         raise


# async def post_error(request):
#     try:
#         userID = request['userID']

#         data = await request.json()
#         sessionId = request.get('SessionTracker')
#         errorCode = data.get('errorCode')
#         errorMessage = data.get('errorMessage')

#         repo = request.app['resturantcommondb']

#         all_roles = await repo.post_error(sessionId, userID, errorCode, errorMessage)
#         return jsonify({
#             'response': "SUCCESS"
#         })
#     except Exception as e:
#         logger.exception(f"Error while post_error : {e}")
#         raise


# async def get_my_platforms(request):
#     try:
#         repo = request.app['resturantcommondb']
#         feature_access = await repo.get_my_platforms(request['user_groups_list'])

#         return jsonify({
#             'my_platforms': feature_access
#         })
#     except Exception as e:
#         logger.exception(f"Error while get_my_platforms : {e}")
#         raise


# async def logout(request):
#     try:
#         userID = request.get('userID', '')
#         request.app['user_auth_cache'].pop(userID, None)

#         # popping out api common me data from the cache
#         request.app['user_api_common_cache'].pop(
#             request.get('SessionTracker', '')+userID, None)

#         logger.info(
#             f"logout(): User={Crypto.AESEncryptWithAppKey(userID)} detail=Successful")
#         return jsonify({
#             'logout': 'Successful'
#         })
#     except Exception as e:
#         logger.error(
#             f"logout(): User={Crypto.AESEncryptWithAppKey(userID)} detail=Failed to delete user session - {e}")
#         return jsonify({
#             'logout': 'UnSuccessful'
#         })


# async def get_client_config_values(request):

#     try:
#         data = {}
#         for key, value in request.app['clientconfig'].items():
#             data[key] = value
#             #print('test',key ,":", data[key])

#         return jsonify({
#             'systemStatusFetchIntervalInSec': data["systemStatusFetchIntervalInSec"],
#             'liveLogStatusFetchWaitTimeInSec': data["liveLogStatusFetchWaitTimeInSec"],
#             'maxWaitTimeToFetchNewLiveLogErrorInMin': data["maxWaitTimeToFetchNewLiveLogErrorInMin"],
#             'maxWaitTimeToQuitLiveLogInMin': data["maxWaitTimeToQuitLiveLogInMin"],
#             'maxWaitTimeToEnableDvmsServiceInSec': data["maxWaitTimeToEnableDvmsServiceInSec"],
#             'certExpireNumberOfDaysLongAway': data["certExpireNumberOfDaysLongAway"],
#             'certExpireNumberOfDaysMediumAway': data["certExpireNumberOfDaysMediumAway"],
#             'certExpireNumberOfDaysShortAway': data["certExpireNumberOfDaysShortAway"],
#             'shrTimeTrackingFetchIntervalInSec': data["shrTimeTrackingFetchIntervalInSec"],
#             'dvkbUrl': data["dvkbUrl"],
#             "crmSrUrl": data["crmSrUrl"],
#             "domainURI": data["domainuri"],
#         })
#     except Exception as e:
#         logger.exception(f"Error while get_client_config_values : {e}")
#         # raise
