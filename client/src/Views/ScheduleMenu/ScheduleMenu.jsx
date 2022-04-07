import "./menuList.css";

import React, {useEffect,useState} from 'react'
import { axiosPost,axiosGet
 } from  "../../common";
import MUIDataTable from 'mui-datatables';
import {CardMedia,Card,CardActions,CardContent,Typography,IconButton,CardHeader,Avatar,Grid,Backdrop,Button,CircularProgress,FormControlLabel,Checkbox,FormGroup, Link} from '@material-ui/core';

import { red,green,purple } from '@material-ui/core/colors';

import {Edit,Pause,PlayArrow,Update}from '@material-ui/icons';
//import EditMenu  from "./modal/EditMenu";


import {
  makeStyles,
  ThemeProvider,
  createTheme,
} from "@material-ui/core/styles";

const useStyles = makeStyles((theme) => ({
  Separator: {
    "&.separator": {
        borderRight: `1px solid ${theme.palette.black}`,
        maxWidth: "0px",
        marginLeft: "5px",
        marginRight: "5px",
    }
},
  root: {
    maxWidth: 300,
    maxHeight:400
  },
  media: {
    height: 0,
    paddingTop: '56.25%', // 16:9
  },
  
  avatarRed: {
    height:35,
    width:35,
    padding:8,
    backgroundColor: red[500],
  },
  avatarGreen: {
    height:35,
    width:35,
    padding:8,
    backgroundColor: green[500],
  },
  avatarPurple: {
    height:35,
    width:35,
    padding:8,
    backgroundColor: purple[500],
  },
  backdrop: {
    zIndex: theme.zIndex.drawer + 1,
    color: '#fff',
  },
}));


export default function ScheduleMenu() {

  const classes = useStyles();

const[loading,setIsLoading]=useState(true);
const[editMenutracking,setMenutracking]=useState([]);

const[updateData,setUpdateData]=useState([]);


  const [items,setitems]=useState([]);
  
  const dataTableTheme = createTheme({
    overrides: {
      MUIDataTableSelectCell: {
        expandDisabled: {
          visibility: "hidden",
        },
        root: {
          backgroundColor: "#FFF",
        },
      },
      MuiTableBody: {
        root: {
          //whiteSpace: "pre",
        },
        "& div[class^='MUIDataTable-responsiveStandard-']": {
          zIndex: 0,
        },
      },
  
      MuiTableRow: {
        head: {
         // whiteSpace: "pre",
        },
      },

    
    },
  });



  const fetchData = async () => {
    setIsLoading(true);

  
    axiosGet('/api/getschedulemenu')
  .then(response =>{
    setitems(response.menu_items);
    setIsLoading(false);
  })
  .catch((e)=>{
    setIsLoading(false);
  })

  };
  useEffect(() => {
    if(items && items.length ===0){
    fetchData();
    }
    setIsLoading(false);

  }, [items]);

    
const getFoodColor=(foodtype)=>{
  if(foodtype==='Mild') return classes.avatarPurple;
  else if (foodtype==='Spicy') return classes.avatarRed;
  else return classes.avatarGreen;


}


const createCheckedValues=(MenuId,CategoryID ,rowdata)=>{


  var test=  rowdata.split(',').map( Number );

  if(test.length>0)
  {

    test.map(i=>{


     const key =Number( String(MenuId)+String(CategoryID)+String(i));

       const found=updateData.length>0 && updateData.some(it=>it.key===key);
         if(!found)
         {
           
           updateData.push( {"key":key,"MenuID":MenuId,"CategoryID":CategoryID,"WeekId":i});

         }

   })
  }
}
const getRows =()=>{

  
  let data=[];
  let columnsarray = [
    "MenuID",
    "MenuItem",
    "Description",
    "MenuItemUrl",
    "Diet",
    "Price",
    "IsActive",
    "Calories",
    "Charecterstic",
    "Appetizer",
    "Salad",
    "MainCourse",
    "Dessert"

  ];

  if(items && items.length >0)
  {
  items.map((item) => {
    data.push(
      columnsarray.map(function (colData) {
  
        //return item[colData]===true?"Yes":item[colData]===false?"No":item[colData]


             if(item[colData]===true)
             {
               return 'Yes'
             }
             if(item[colData]===false)
             {
               return 'No'
             }

             if(colData==='Appetizer')
             {
              
                  if(item[colData] && item[colData].split(',').map( Number ).length>0)
                  {
                    createCheckedValues(item['MenuID'],1,item[colData])
                  }


             }

             if(colData==='Salad')
             {
                  if(item[colData] && item[colData].split(',').map( Number ).length>0)
                  {
                    createCheckedValues(item['MenuID'] ,2,item[colData])
                  }


             }

             if(colData==='MainCourse')
             {
                  if(item[colData] && item[colData].split(',').map( Number ).length>0)
                  {
                    createCheckedValues(item['MenuID'] ,3,item[colData])
                  }


             }

             if(colData==='Dessert')
             {
                  if(item[colData] && item[colData].split(',').map( Number ).length>0)
                  {
                    createCheckedValues(item['MenuID'] ,4,item[colData])
                  }


             }

             return item[colData]
       
       
      })
    );
  });
}



return data;
 
};

const updateSchedule=()=>{

console.log('hai rkr',updateData)
  axiosPost('/api/insertschedule', JSON.stringify({updateData}))
  .then(response =>{
    fetchData();
    setUpdateData([]);
  })
  .catch((e)=>{
    fetchData();
    setIsLoading(false);
    setUpdateData([]);

  })

}


const muicolumns = [
  {
    name: "MenuID",
    options: {
     
      display: false,
          viewColumns: false,
          filter: false,
          
     
    }
  },
  {
    name: "Menu Item",
    options: {
      filter: true,
      display: false,
     
    }
  },
  {
    name: "Description",
    options: {
      filter: true,
      display: false,
     
    }
  },
  
  {
    name: "Menu",
    options: {
      filter: false,
      sort: false,
      customBodyRender: (value, tableMeta, updateValue) => {


       const rowid=tableMeta.rowData;


        return (
       
          <Card className={classes.root}>
          <CardHeader
            avatar={
              <Avatar aria-label="recipe" className={getFoodColor(rowid[8])}>
              {rowid[4]}
              </Avatar>
            }
           
            title={rowid[1]+ "(" +rowid[7]+".Cal" + ")" }
            
          />
          <CardMedia
            className={classes.media}
            image={rowid[3]}
            title={rowid[1]}
          />
      
       
        
         
        </Card>
     
       
        );
      },
    },
  },
  {
    name: "Diet",
    options: {
    
      filter: true,
      display: false,
    }
  },
  {
    name: "Price",
    options: {
    
      filter: true,
      customBodyRender: value => <span>${ Number( value)}</span>

    }
  },
  {
    name: "Status",
    options: {
    
      filter: true,
    }
    
  },
  {
    name: "Calories",
    options: {
    
      filter: true,
      display:false
    }
    
  },
  {
    name: "Taste",
    options: {
    
      filter: true,
      display:false
    }
    
  },


{
    name: "Appetizer",
    options: {

      filter: false,
      display:true,

      customBodyRender: (value, tableMeta, updateValue) => {


         const rowid=tableMeta.rowData;


     
        


 
         return (
        
         
      <Grid container spacing={1}>
          <Grid container item xs={12} spacing={1}>
                <FormGroup row>
                            <FormControlLabel
                            
                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'1'+'1')) } 

                              onChange={(event) => {
                                const key =Number(rowid[0]+'1'+'1');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                if(event.target.checked && !found) 
                                {                              
                                  
                                  const data={"key":key,"MenuID":rowid[0],"CategoryID":1,"WeekId":1}

                                updateData.push(data);

                                }
                                else 
                                {
                                 

                                  const index = updateData.findIndex(x => x.key ===key);

                                  if (index !== undefined) updateData.splice(index, 1);
                                  


                                }

                            }}
                              />}
                              label="Sun"
                            />
                            <FormControlLabel
                              //control={<Checkbox defaultChecked={nameArr && nameArr.includes(2)  } 
                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'1'+'2')) } 

                              onChange={(event) => {
                                const key =Number(rowid[0]+'1'+'2');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                  if(event.target.checked && !found) 
                                  {                              
                                    
                                    const data={"key":key,"MenuID":rowid[0],"CategoryID":1,"WeekId":2}
  
                                  updateData.push(data);
  
                                  }
                                  else 
                                  {
                                   
  
                                    const index = updateData.findIndex(x => x.key ===key);
  
                                    if (index !== undefined) updateData.splice(index, 1);
                                    
  
  
                                  }
  
                              }}
                              />}
                              label="Mon"
                            />
                            <FormControlLabel
                              //control={<Checkbox defaultChecked={nameArr && nameArr.includes(3)   } 
                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'1'+'3')) } 

                              onChange={(event) => {
                                const key =Number(rowid[0]+'1'+'3');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                  if(event.target.checked && !found) 
                                  {                              
                                    
                                    const data={"key":key,"MenuID":rowid[0],"CategoryID":1,"WeekId":3}
  
                                  updateData.push(data);
  
                                  }
                                  else 
                                  {
                                   
  
                                    const index = updateData.findIndex(x => x.key ===key);
  
                                    if (index !== undefined) updateData.splice(index, 1);
                                    
  
  
                                  }
  
                              }}
                              />}
                              label="Tue"
                            />
                          
                  
                
                <FormControlLabel
                              // control={<Checkbox defaultChecked={(nameArr && nameArr.includes(4)  ) }

                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'1'+'4')) } 
                              value={value}   
                              onChange={(event) => {
                                const key =Number(rowid[0]+'1'+'4');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                  if(event.target.checked && !found) 
                                  {                              
                                    
                                    const data={"key":key,"MenuID":rowid[0],"CategoryID":1,"WeekId":4}
  
                                   updateData.push(data);
  
                                  }
                                  else 
                                  {
                                   
  
                                    const index = updateData.findIndex(x => x.key ===key);
  
                                    if (index !== undefined) updateData.splice(index, 1);
                                    
  
  
                                  }
  
                              }}
                              />}
                              label="Wed"
                            />
                <FormControlLabel
                              // control={<Checkbox defaultChecked={(nameArr && nameArr.includes(5)  ) }

                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'1'+'5')) } 
                              value={value}   
                              onChange={(event) => {
                                const key =Number(rowid[0]+'1'+'5');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                  if(event.target.checked && !found) 
                                  {                              
                                    
                                    const data={"key":key,"MenuID":rowid[0],"CategoryID":1,"WeekId":5}
  
                                  updateData.push(data);
  
                                  }
                                  else 
                                  {
                                   
  
                                    const index = updateData.findIndex(x => x.key ===key);
  
                                    if (index !== undefined) updateData.splice(index, 1);
                                    
  
  
                                  }
  
                              }}
                              />}
                              label="Thu"
                            />
                            <FormControlLabel
                              // control={<Checkbox defaultChecked={nameArr && nameArr.includes(6)   } 

                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'1'+'6')) } 
                              onChange={(event) => {
                                const key =Number(rowid[0]+'1'+'6');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                  if(event.target.checked && !found) 
                                  {                              
                                    
                                    const data={"key":key,"MenuID":rowid[0],"CategoryID":1,"WeekId":6}
  
                                  updateData.push(data);
  
                                  }
                                  else 
                                  {
                                   
  
                                    const index = updateData.findIndex(x => x.key ===key);
  
                                    if (index !== undefined) updateData.splice(index, 1);
                                    
  
  
                                  }
  
                              }}
                              />}
                              label="Fri"
                            />
                            <FormControlLabel
                              // control={<Checkbox defaultChecked={nameArr && nameArr.includes(7)   } 

                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'1'+'7')) } 

                              onChange={(event) => {
                                const key =Number(rowid[0]+'1'+'7');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                  if(event.target.checked && !found) 
                                  {                              
                                    
                                    const data={"key":key,"MenuID":rowid[0],"CategoryID":1,"WeekId":7}
  
                                  updateData.push(data);
  
                                  }
                                  else 
                                  {
                                   
  
                                    const index = updateData.findIndex(x => x.key ===key);
  
                                    if (index !== undefined) updateData.splice(index, 1);
                                    
  
  
                                  }
  
                              }}
                              />}
                              label="Sat"
                            />
                          
                
                  </FormGroup >

          </Grid>
      </Grid>
 
        
         );
       },
    }
    
  },



  {
    name: "Salad",
    options: {

      filter: false,
      display:true,

      customBodyRender: (value, tableMeta, updateValue) => {


        const rowid=tableMeta.rowData;

      //  nameArr =  rowid[10] ? rowid[10].split(',').map( Number ):[];


      //  if(nameArr.length>0)
      //  {

      //   nameArr.map(i=>{


      //     const key =Number(rowid[0]+'2'+i);

      //       const found=updateData.length>0 && updateData.some(it=>it.key===key);
      //         if(!found)
      //         {
                
      //           updateData.push({"key":key,"MenuID":rowid[0],"CategoryID":2,"WeekId":i});

      //         }

      //   })

          

       
      //  }
        


 
         return (
        
         
      <Grid container spacing={1}>
          <Grid container item xs={12} spacing={1}>
                <FormGroup row>
                            <FormControlLabel
                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'2'+'1')) } 
                              onChange={(event) => {
                                const key =Number(rowid[0]+'2'+'1');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                if(event.target.checked && !found) 
                                {                              
                                  
                                  const data={"key":key,"MenuID":rowid[0],"CategoryID":2,"WeekId":1}

                                updateData.push(data);

                                }
                                else 
                                {
                                 

                                  const index = updateData.findIndex(x => x.key ===key);

                                  if (index !== undefined) updateData.splice(index, 1);
                                  


                                }

                            }}
                              />}
                              label="Sun"
                            />
                            <FormControlLabel
                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'2'+'2')) } 
                              onChange={(event) => {
                                const key =Number(rowid[0]+'2'+'2');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                  if(event.target.checked && !found) 
                                  {                              
                                    
                                    const data={"key":key,"MenuID":rowid[0],"CategoryID":2,"WeekId":2}
  
                                  updateData.push(data);
  
                                  }
                                  else 
                                  {
                                   
  
                                    const index = updateData.findIndex(x => x.key ===key);
  
                                    if (index !== undefined) updateData.splice(index, 1);
                                    
  
  
                                  }
  
                              }}
                              />}
                              label="Mon"
                            />
                            <FormControlLabel
                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'2'+'3')) } 
                              onChange={(event) => {
                                const key =Number(rowid[0]+'2'+'3');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                  if(event.target.checked && !found) 
                                  {                              
                                    
                                    const data={"key":key,"MenuID":rowid[0],"CategoryID":2,"WeekId":3}
  
                                  updateData.push(data);
  
                                  }
                                  else 
                                  {
                                   
  
                                    const index = updateData.findIndex(x => x.key ===key);
  
                                    if (index !== undefined) updateData.splice(index, 1);
                                    
  
  
                                  }
  
                              }}
                              />}
                              label="Tue"
                            />
                          
                  
                
                 

                <FormControlLabel
                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'2'+'4')) } 
                              value={value}   
                              onChange={(event) => {
                                const key =Number(rowid[0]+'2'+'4');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                  if(event.target.checked && !found) 
                                  {                              
                                    
                                    const data={"key":key,"MenuID":rowid[0],"CategoryID":2,"WeekId":4}
  
                                   updateData.push(data);
  
                                  }
                                  else 
                                  {
                                   
  
                                    const index = updateData.findIndex(x => x.key ===key);
  
                                    if (index !== undefined) updateData.splice(index, 1);
                                    
  
  
                                  }
  
                              }}
                              />}
                              label="Wed"
                            />
                <FormControlLabel
                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'2'+'5')) } 
                              value={value}   
                              onChange={(event) => {
                                const key =Number(rowid[0]+'2'+'5');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                  if(event.target.checked && !found) 
                                  {                              
                                    
                                    const data={"key":key,"MenuID":rowid[0],"CategoryID":2,"WeekId":5}
  
                                  updateData.push(data);
  
                                  }
                                  else 
                                  {
                                   
  
                                    const index = updateData.findIndex(x => x.key ===key);
  
                                    if (index !== undefined) updateData.splice(index, 1);
                                    
  
  
                                  }
  
                              }}
                              />}
                              label="Thu"
                            />
                            <FormControlLabel
                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'2'+'6')) } 
                              onChange={(event) => {
                                const key =Number(rowid[0]+'2'+'6');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                  if(event.target.checked && !found) 
                                  {                              
                                    
                                    const data={"key":key,"MenuID":rowid[0],"CategoryID":2,"WeekId":6}
  
                                  updateData.push(data);
  
                                  }
                                  else 
                                  {
                                   
  
                                    const index = updateData.findIndex(x => x.key ===key);
  
                                    if (index !== undefined) updateData.splice(index, 1);
                                    
  
  
                                  }
  
                              }}
                              />}
                              label="Fri"
                            />
                            <FormControlLabel
                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'2'+'7')) } 
                              onChange={(event) => {
                                const key =Number(rowid[0]+'2'+'7');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                  if(event.target.checked && !found) 
                                  {                              
                                    
                                    const data={"key":key,"MenuID":rowid[0],"CategoryID":2,"WeekId":7}
  
                                  updateData.push(data);
  
                                  }
                                  else 
                                  {
                                   
  
                                    const index = updateData.findIndex(x => x.key ===key);
  
                                    if (index !== undefined) updateData.splice(index, 1);
                                    
  
  
                                  }
  
                              }}
                              />}
                              label="Sat"
                            />
                          
                
                  </FormGroup >

          </Grid>
      </Grid>
 
        
         );
       },
    }
    
  },
  
  {
    name: "Main Course",
    options: {

      filter: false,
      display:true,

      customBodyRender: (value, tableMeta, updateValue) => {


        const rowid=tableMeta.rowData;

      //  nameArr =  rowid[11] ? rowid[11].split(',').map( Number ):[];


      //  if(nameArr.length>0)
      //  {

      //   nameArr.map(i=>{


      //     const key =Number(rowid[0]+'3'+i);

      //       const found=updateData.length>0 && updateData.some(it=>it.key===key);
      //         if(!found)
      //         {
                
      //           updateData.push( {"key":key,"MenuID":rowid[0],"CategoryID":3,"WeekId":i});

      //         }

      //   })

          

       
      //  }
        


 
         return (
        
         
      <Grid container spacing={1}>
          <Grid container item xs={12} spacing={1}>
                <FormGroup row>
                            <FormControlLabel
                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'3'+'1')) } 
                              onChange={(event) => {
                                const key =Number(rowid[0]+'3'+'1');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                if(event.target.checked && !found) 
                                {                              
                                  
                                  const data={"key":key,"MenuID":rowid[0],"CategoryID":3,"WeekId":1}

                                updateData.push(data);

                                }
                                else 
                                {
                                 

                                  const index = updateData.findIndex(x => x.key ===key);

                                  if (index !== undefined) updateData.splice(index, 1);
                                  


                                }

                            }}
                              />}
                              label="Sun"
                            />
                            <FormControlLabel
                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'3'+'2')) } 
                              onChange={(event) => {
                                const key =Number(rowid[0]+'3'+'2');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                  if(event.target.checked && !found) 
                                  {                              
                                    
                                    const data={"key":key,"MenuID":rowid[0],"CategoryID":3,"WeekId":2}
  
                                  updateData.push(data);
  
                                  }
                                  else 
                                  {
                                   
  
                                    const index = updateData.findIndex(x => x.key ===key);
  
                                    if (index !== undefined) updateData.splice(index, 1);
                                    
  
  
                                  }
  
                              }}
                              />}
                              label="Mon"
                            />
                            <FormControlLabel
                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'3'+'3')) } 
                              onChange={(event) => {
                                const key =Number(rowid[0]+'3'+'3');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                  if(event.target.checked && !found) 
                                  {                              
                                    
                                    const data={"key":key,"MenuID":rowid[0],"CategoryID":3,"WeekId":3}
  
                                  updateData.push(data);
  
                                  }
                                  else 
                                  {
                                   
  
                                    const index = updateData.findIndex(x => x.key ===key);
  
                                    if (index !== undefined) updateData.splice(index, 1);
                                    
  
  
                                  }
  
                              }}
                              />}
                              label="Tue"
                            />
                          
                  
                
                 
                
                <FormControlLabel
                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'3'+'4')) } 
                              value={value}   
                              onChange={(event) => {
                                const key =Number(rowid[0]+'3'+'4');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                  if(event.target.checked && !found) 
                                  {                              
                                    
                                    const data={"key":key,"MenuID":rowid[0],"CategoryID":3,"WeekId":4}
  
                                   updateData.push(data);
  
                                  }
                                  else 
                                  {
                                   
  
                                    const index = updateData.findIndex(x => x.key ===key);
  
                                    if (index !== undefined) updateData.splice(index, 1);
                                    
  
  
                                  }
  
                              }}
                              />}
                              label="Wed"
                            />
                <FormControlLabel
                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'3'+'5')) } 
                              value={value}   
                              onChange={(event) => {
                                const key =Number(rowid[0]+'3'+'5');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                  if(event.target.checked && !found) 
                                  {                              
                                    
                                    const data={"key":key,"MenuID":rowid[0],"CategoryID":3,"WeekId":5}
  
                                  updateData.push(data);
  
                                  }
                                  else 
                                  {
                                   
  
                                    const index = updateData.findIndex(x => x.key ===key);
  
                                    if (index !== undefined) updateData.splice(index, 1);
                                    
  
  
                                  }
  
                              }}
                              />}
                              label="Thu"
                            />
                            <FormControlLabel
                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'3'+'6')) } 
                              onChange={(event) => {
                                const key =Number(rowid[0]+'3'+'6');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                  if(event.target.checked && !found) 
                                  {                              
                                    
                                    const data={"key":key,"MenuID":rowid[0],"CategoryID":3,"WeekId":6}
  
                                  updateData.push(data);
  
                                  }
                                  else 
                                  {
                                   
  
                                    const index = updateData.findIndex(x => x.key ===key);
  
                                    if (index !== undefined) updateData.splice(index, 1);
                                    
  
  
                                  }
  
                              }}
                              />}
                              label="Fri"
                            />
                            <FormControlLabel
                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'3'+'7')) } 
                              onChange={(event) => {
                                const key =Number(rowid[0]+'3'+'7');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                  if(event.target.checked && !found) 
                                  {                              
                                    
                                    const data={"key":key,"MenuID":rowid[0],"CategoryID":3,"WeekId":7}
  
                                  updateData.push(data);
  
                                  }
                                  else 
                                  {
                                   
  
                                    const index = updateData.findIndex(x => x.key ===key);
  
                                    if (index !== undefined) updateData.splice(index, 1);
                                    
  
  
                                  }
  
                              }}
                              />}
                              label="Sat"
                            />
                          
                
                  </FormGroup >

          </Grid>
      </Grid>
 
        
         );
       },
    }
    
  },
  
  {
    name: "Dessert",
    options: {

      filter: false,
      display:true,

      customBodyRender: (value, tableMeta, updateValue) => {


        const rowid=tableMeta.rowData;

     
          

       
    
        


 
         return (
        
         
      <Grid container spacing={1}>
          <Grid container item xs={12} spacing={1}>
                <FormGroup row>
                            <FormControlLabel
                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'4'+'1')) } 
                              onChange={(event) => {
                                const key =Number(rowid[0]+'4'+'1');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                if(event.target.checked && !found) 
                                {                              
                                  
                                  const data={"key":key,"MenuID":rowid[0],"CategoryID":4,"WeekId":1}

                                updateData.push(data);

                                }
                                else 
                                {
                                 

                                  const index = updateData.findIndex(x => x.key ===key);

                                  if (index !== undefined) updateData.splice(index, 1);
                                  


                                }

                            }}
                              />}
                              label="Sun"
                            />
                            <FormControlLabel
                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'4'+'2')) } 
                              onChange={(event) => {
                                const key =Number(rowid[0]+'4'+'2');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                  if(event.target.checked && !found) 
                                  {                              
                                    
                                    const data={"key":key,"MenuID":rowid[0],"CategoryID":4,"WeekId":2}
  
                                  updateData.push(data);
  
                                  }
                                  else 
                                  {
                                   
  
                                    const index = updateData.findIndex(x => x.key ===key);
  
                                    if (index !== undefined) updateData.splice(index, 1);
                                    
  
  
                                  }
  
                              }}
                              />}
                              label="Mon"
                            />
                            <FormControlLabel
                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'4'+'3')) } 
                              onChange={(event) => {
                                const key =Number(rowid[0]+'4'+'3');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                  if(event.target.checked && !found) 
                                  {                              
                                    
                                    const data={"key":key,"MenuID":rowid[0],"CategoryID":4,"WeekId":3}
  
                                  updateData.push(data);
  
                                  }
                                  else 
                                  {
                                   
  
                                    const index = updateData.findIndex(x => x.key ===key);
  
                                    if (index !== undefined) updateData.splice(index, 1);
                                    
  
  
                                  }
  
                              }}
                              />}
                              label="Tue"
                            />
                          
                  
                
                <FormControlLabel
                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'4'+'4')) } 
                              value={value}   
                              onChange={(event) => {
                                const key =Number(rowid[0]+'4'+'4');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                  if(event.target.checked && !found) 
                                  {                              
                                    
                                    const data={"key":key,"MenuID":rowid[0],"CategoryID":4,"WeekId":4}
  
                                   updateData.push(data);
  
                                  }
                                  else 
                                  {
                                   
  
                                    const index = updateData.findIndex(x => x.key ===key);
  
                                    if (index !== undefined) updateData.splice(index, 1);
                                    
  
  
                                  }
  
                              }}
                              />}
                              label="Wed"
                            />
                <FormControlLabel
                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'4'+'5')) } 
                              value={value}   
                              onChange={(event) => {
                                const key =Number(rowid[0]+'4'+'5');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                  if(event.target.checked && !found) 
                                  {                              
                                    
                                    const data={"key":key,"MenuID":rowid[0],"CategoryID":4,"WeekId":5}
  
                                  updateData.push(data);
  
                                  }
                                  else 
                                  {
                                   
  
                                    const index = updateData.findIndex(x => x.key ===key);
  
                                    if (index !== undefined) updateData.splice(index, 1);
                                    
  
  
                                  }
  
                              }}
                              />}
                              label="Thu"
                            />
                            <FormControlLabel
                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'4'+'6')) } 
                              onChange={(event) => {
                                const key =Number(rowid[0]+'4'+'6');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                  if(event.target.checked && !found) 
                                  {                              
                                    
                                    const data={"key":key,"MenuID":rowid[0],"CategoryID":4,"WeekId":6}
  
                                  updateData.push(data);
  
                                  }
                                  else 
                                  {
                                   
  
                                    const index = updateData.findIndex(x => x.key ===key);
  
                                    if (index !== undefined) updateData.splice(index, 1);
                                    
  
  
                                  }
  
                              }}
                              />}
                              label="Fri"
                            />
                            <FormControlLabel
                              control={<Checkbox defaultChecked={updateData.length>0 && updateData.some(it=>it.key===Number(rowid[0]+'4'+'7')) } 
                              onChange={(event) => {
                                const key =Number(rowid[0]+'4'+'7');

                                const found=updateData.length>0 && updateData.some(it=>it.key===key);
                                  if(event.target.checked && !found) 
                                  {                              
                                    
                                    const data={"key":key,"MenuID":rowid[0],"CategoryID":4,"WeekId":7}
  
                                  updateData.push(data);
  
                                  }
                                  else 
                                  {
                                   
  
                                    const index = updateData.findIndex(x => x.key ===key);
  
                                    if (index !== undefined) updateData.splice(index, 1);
                                    
  
  
                                  }
  
                              }}
                              />}
                              label="Sat"
                            />
                          
                
                  </FormGroup >

          </Grid>
      </Grid>
 
        
         );
       },
    }
    
  },

  

];


const options = {
 
  selectableRows: "none",
  filterType: 'dropdown',
  responsive: 'vertical',
  download: false,
  print: false,
  rowsPerPage: 100,
  tableBodyHeight: "1000px",
  selectableRowsHeader: false,
      selectableRowsOnClick: false,
      customToolbar: () => {
        return (
          <Button          color="primary" variant="contained" onClick={updateSchedule} >Update</Button>


        );
      }

};

 console.log('updatedata',updateData);

  return (

    <div className="userList" >
   {loading &&
         <Backdrop className={classes.backdrop} open={loading} >

   <CircularProgress
                style={{ position: "absolute", top: "50%", left: "50%" }}
              />
                    </Backdrop>}

       
            <ThemeProvider theme={dataTableTheme}>
                  <MUIDataTable title={"Menu List"} data={getRows()} columns={muicolumns} options={options}  />
            </ThemeProvider>
            
    </div>
  );
}
