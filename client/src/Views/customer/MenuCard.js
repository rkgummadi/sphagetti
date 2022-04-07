import React,{useContext} from 'react'
import {itemContext} from "../../App"
import "../../../node_modules/bootstrap/dist/css/bootstrap.css"
import "../../../node_modules/bootstrap-icons/font/bootstrap-icons.css";


function MenuCard({data}) {
    //console.log("menucard rendered",data);
    const iL = useContext(itemContext);
    
    const sendId=(id)=>{
        iL.method({type:'set_id',payload:id});
    }

    const increment=()=>{
        console.log("increment link  rendered",data);

        iL.method({type:'addItem',payload:data})
        iL.method({type:'getTotalItems'})           
    };
   

    const colorCircle = data.diet.toLowerCase() ==="v" ? <i className="bi bi-circle-fill greenColor"></i> :
    data.diet.toLowerCase() ==="nv" ? <i className="bi bi-circle-fill redColor "></i> : <i className="bi bi-circle-fill purpleColor"></i>
    
    return (
        <>
       <div key ={data.id} className="menuCard d-flex justify-content-between flex-wrap" onClick={()=>sendId(data.MenuID)}>
           <div className="d-flex flex-column itemDescription">
               <div>
               <div className="h5">{data.Menu +'('+'Cal:'+data.Calories+')'}</div>
               <div>{colorCircle}{' '}{data.diet}</div>
               </div>
               <div className="py-2">${Number( data.Price)}</div>
                <button type="button" className="btn btn-outline-warning mt-auto p-2 w-50 addCart" onClick={increment}>Add to cart</button>
    </div>
           <div className="menuCardImg position-relative">
               
               <img alt="" className="img-fluid img-rounded" src={data.MenuItemUrl} width={175} height={90}/>
               {/* {data.Menu !=="" ? <span className="position-absolute top-0 end-0 bg-primary badge" style={{padding:"5px"}}>{data.Menu}</span> : ''} */}
           </div>
       </div>
       
      </>
    )
}

export default React.memo(MenuCard);
