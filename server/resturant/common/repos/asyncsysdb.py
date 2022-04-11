import json
from resturant.common.json import jsonify

from aiocache import cached

from resturant.common.database import Database
from resturant.common.mssql import TableValuedParams, prepare_exec

class resturantDatabaseRepo:

    def __init__(self, url, config, **kwargs):
        self.db = Database(url, config, **kwargs)
    



    async def insert_schedule(self,scheduleData):
        
        #print('rkr',TableValuedParams('dbo.schedulemenu', [(g['CategoryID'],g['MenuID'],g['WeekId']) for g in scheduleData], ['CategoryID','MenuID', 'WeekId']))
        try:
            operation = prepare_exec('dbo.insertschedule', 
           
            tabledata=TableValuedParams('dbo.schedulemenu', [(g['CategoryID'],g['MenuID'],g['WeekId']) for g in scheduleData], ['CategoryID','MenuID', 'WeekId']), 
          
            ).execution_options(autocommit=True)

            await self.db.execute(operation)
        except Exception as e:
            #logger.exception(f"Error while create_user_role_change_request : {e}")
            raise

    
    async def get_today_menu(self):
        operation = prepare_exec(
            '[dbo].[GetItemsForDay]'
           )
        
        result = await self.db.execute(operation)
       
        return  result.all(as_dict=True)



    
    async def Get_Schedule_Menu(self):
        operation = prepare_exec(
            ' [dbo].[get_Schedule_menu]'
           )
        
        result = await self.db.execute(operation)
        return result.all(as_dict=True)

    async def Get_Menu_items(self):
        operation = prepare_exec(
            'dbo.GetMenuitems'
           )
        
        result = await self.db.execute(operation)
        return result.all(as_dict=True)

    async def get_menu_byday(self, day):
        operation = prepare_exec(
            '[dbo].[GetItemsForDay]',
            dayofWeek =day)
        result = await self.db.execute(operation)
        return result.all(as_dict=True)
        
    async def get_user_role(self,user):
        operation = prepare_exec(
            'dbo.GetuserRole',username=user
        )
        result = await self.db.execute(operation)
        return result.all(as_dict=True)

    async def update_menu(self,request):

        try:
            operation = prepare_exec('[dbo].[update_menu]',             
            MenuId=request.get('MenuId'), 
            MenuItem=request.get('MenuItem'),
            MenuItemUrl=request.get('MenuItemUrl'),
            Description=request.get('Description'),
            Price=request.get('Price'),
            Diet=request.get('Diet'),
            Calories=request.get('Calories'),
            Charecterstic=request.get('Charecterstic'),
            IsActive=request.get('IsActive')
            ).execution_options(autocommit=True)
            await self.db.execute(operation)


        except Exception as e:
            print(e)
            raise
    
    async def insert_menu(self,request):
        print('rk',request)
        try:
            operation = prepare_exec('[dbo].[insert_menu]',             
            MenuItem=request.get('MenuItem'),
            MenuItemUrl=request.get('MenuItemUrl'),
            Description=request.get('Description'),
            Price=request.get('Price'),
            Diet=request.get('Diet'),
            Calories=request.get('Calories'),
            Charecterstic=request.get('Charecterstic'),
            IsActive=request.get('IsActive')
            ).execution_options(autocommit=True)
            await self.db.execute(operation)


        except Exception as e:
            print(e)
            raise