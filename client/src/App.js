import Sidebar from "./components/sidebar/Sidebar";
import Topbar from "./components/topbar/Topbar";
import "./App.css";
import { BrowserRouter as Router, Switch, Route } from "react-router-dom";
import React, { useReducer,useState,useEffect } from "react";
import { axiosPost,axiosGet } from  "./common";

import MenuListItems from "./Views/MenuItems/MenuListItems";
import ScheduleMenu from "./Views/ScheduleMenu/ScheduleMenu";
import Menu  from "./Views/customer/Menu";


//import Menu  from "./Views/test/Menu";

var store = require("store");

store.clearAll()

export const itemContext = React.createContext();
const initialState = {
  id: 0,
  list: store.get("orderedItems") ?? [],
  totalItems: store.get("totalitems") ?? 0,
  totalCost: store.get("totalCost") ?? 0,
};
const myReducer = (state = initialState, action) => {
  const { type } = action;
  switch (type) {
    case "set_id":
      return { ...state, id: action.payload };
    case "addItem":

    
      let { list } = state;
      let { payload } = action;

      if (list === undefined || list.length === 0) {
        let newList = { ...state, list: [{ ...payload, quantity: 1 }] };
        store.set("orderedItems", newList["list"]);
        return newList;
      } else if (list.filter((item) => item.MenuID === payload.MenuID).length === 0) {
        let newList = {
          ...state,
          list: [...list, { ...payload, quantity: 1 }],
        };
        store.set("orderedItems", newList["list"]);
        return newList;
      } else {
        let newList = {
          ...state,
          list: list.map((item) =>
            item.MenuID === payload.MenuID
              ? { ...item, quantity: item.quantity + 1 }
              : item
          ),
        };
        store.set("orderedItems", newList["list"]);
        return newList;
      }
    case "deleteItem":
      let pll = action.payload;
      //console.log("in delete");
      const t = state.list.map((item) =>
        item.MenuID === pll.MenuID ? { ...item, quantity: item.quantity - 1 } : item
      );
      let newList = { ...state, list: t.filter((a) => a.quantity !== 0) };
      store.set("orderedItems", newList["list"]);
      if (store.get("orderedItems").length === 0) {
        store.set("totalitems", 0);
        store.set("totalCost", 0);
      }
      return newList;

    case "getTotalItems":
      if (state.list.length > 0) {
        let totalitems = {
          ...state,
          totalItems: state.list.map((a) => a.quantity).reduce((a, b) => a + b),
        };
        store.set("totalitems", totalitems["totalItems"]);
        return totalitems;
      } else return { ...state, totalItems: 0 };

    case "clearCart":
      store.remove("orderedItems");
      store.remove("totalitems");
      return { ...state, list: [] };
    case "totalCost":
      if (state.list.length > 0) {
        store.set(
          "totalCost",
          state.list.map((l) => l.quantity * l.Price).reduce((a, b) => a + b)
        );
        return {
          ...state,
          totalCost: state.list
            .map((l) => l.quantity * l.Price)
            .reduce((a, b) => a + b),
        };
      }
      break;
   

    default:
      return state;
  }
};
function App() {
  const [myState, dispatch] = useReducer(myReducer, initialState);
  const[loading,setIsLoading]=useState(true);
  const[user,setUser]=useState('');


  const fetchData = async () => {
    setIsLoading(true);

  
    axiosGet('/api/me')
  .then(response =>{
    setUser(response.user);
    setIsLoading(false);
  })
  .catch((e)=>{
    setIsLoading(false);
  })

    
  };
  useEffect(() => {
    if(!user){
    fetchData();
    }
    setIsLoading(false);

  }, [user]);

  
 return (
    <itemContext.Provider value={{ state: myState, method: dispatch }}>

    <Router>
      {/* <Topbar /> */}
      <div className="container">

        {
        user && user==='customer' ?
        
        <Switch>
       
          <Route exact path="/">
            <Menu/>
          </Route>

       
        </Switch> :


        user && user==='chef' ?  <Switch>
       
       <Route  exact path="/">
       <MenuListItems />
       </Route>
      
      
     </Switch> :


     user && user==='manager' ?
     <>
        <Switch>
        <Route exact path="/menulist">
        <Sidebar/>

            <MenuListItems />
          </Route>
          <Route exact path="/">
          <Sidebar/>

            <ScheduleMenu />
          </Route>
         
       
          <Route exact path="/menu">
          
            <Menu    />
          </Route>
        </Switch>

        </>
        :''
       
        
        }
      </div>
    </Router>
    </itemContext.Provider>

  );
}

export default App;
