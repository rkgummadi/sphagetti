import React, {useEffect,useState} from 'react'
import { axiosPost,axiosGet } from  "../../common"
import MenuCard from './MenuCard';
//import {itemContext} from '../App';
import "./customer.css"
var store =require('store');

function RestaurantMenu() {
  const [items,setitems]=useState(store.get('items') ?? []);
  const [loading,setLoading]=useState(store.get('loading') ?? true);
  const [error, setError]=useState(store.get('error') ?? '');



useEffect(()=>{
  if(items.length ===0){
    axiosGet('/api/gettodaymenu')
  .then(response =>{


  var data=response.menu_items;    
   

    var result_dataset=[];

    result_dataset.push(
      {  "CategoryID": 1,
      "Category": "Appetizer","Menu":
    data.filter(
         (z) => z.CategoryID ===1).map( (i)=> (  {MenuID:i.MenuID,Menu:i.MenuItem,MenuItemUrl:i.MenuItemUrl,Price:i.Price,Charecterstic:i.Charecterstic,Description:i.Description,diet:i.diet,Calories:i.Calories}))}
 
    )

    result_dataset.push(
      {  "CategoryID": 2,
      "Category": "Salad","Menu":
    data.filter(
         (z) => z.CategoryID ===2).map( (i)=> (  {MenuID:i.MenuID,Menu:i.MenuItem,MenuItemUrl:i.MenuItemUrl,Price:i.Price,Charecterstic:i.Charecterstic,Description:i.Description,diet:i.diet,Calories:i.Calories}))}
 
    )

    result_dataset.push(
      {  "CategoryID": 3,
      "Category": "MainCourse","Menu":
    data.filter(
         (z) => z.CategoryID ===3).map( (i)=> (  {MenuID:i.MenuID,Menu:i.MenuItem,MenuItemUrl:i.MenuItemUrl,Price:i.Price,Charecterstic:i.Charecterstic,Description:i.Description,diet:i.diet,Calories:i.Calories}))}
 
    )

    result_dataset.push(
      {  "CategoryID": 4,
      "Category": "Dessert","Menu":
    data.filter(
         (z) => z.CategoryID ===4).map( (i)=> (  {MenuID:i.MenuID,Menu:i.MenuItem,MenuItemUrl:i.MenuItemUrl,Price:i.Price,Charecterstic:i.Charecterstic,Description:i.Description,diet:i.diet,Calories:i.Calories}))}
 
    )



    store.set('error', '');
    store.set('loading', false);
    store.set('items', response.data);
   




     setLoading(false);
    setError('');    
     setitems(result_dataset);
  })
  .catch((e)=>{
    store.set('loading', false);
    store.set('error', e.message);
    setError(e.message);
  })
}
},[items])
    
    return (
     error!=="" ? <h2 className="text-center text-danger border border-dark p-2 position-absolute top-50 start-50 translate-middle">{`${error}. Please try after sometime`}</h2> : loading === false ?
      

      (<div className="container-fluid menuLayout">
      {items && items.map((item) =>
      (<div key={item.CategoryID} className="container d-flex flex-column">
      <div className="h3 tt" id={item.Category}>{item.Category}</div>     
      <div className="menuCardWrapper d-flex flex-wrap">
      {item.Menu && item.Menu.map(i=>
        <MenuCard data={i} key={i.MenuID}/>  
        )}    
      </div>
      </div> )
      )}
      </div>):
        (
          <div className="spinnerBlock d-flex justify-content-center">
          <div className="spinner-grow text-secondary" role="status">
  <span className="visually-hidden">Loading...</span>
</div>
<div className="spinner-grow text-danger" role="status">
  <span className="visually-hidden">Loading...</span>
</div>
<div className="spinner-grow text-warning" role="status">
  <span className="visually-hidden">Loading...</span>
</div>
</div>
        )
      
    )
}

export default React.memo(RestaurantMenu)
