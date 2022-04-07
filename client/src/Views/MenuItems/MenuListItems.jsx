import "./menuList.css";

import React, {useEffect,useState} from 'react'
import { axiosPost,axiosGet } from  "../../common";
import MUIDataTable from 'mui-datatables';
import {CardMedia,Card,CardActions,CardContent,Typography,IconButton,CardHeader,Avatar,Grid,Backdrop,Button,CircularProgress} from '@material-ui/core';

import { red,green,purple } from '@material-ui/core/colors';


import {Edit,Pause,PlayArrow,Add}from '@material-ui/icons';
import EditMenu  from "./modal/EditMenu";


import {
  makeStyles,
  ThemeProvider,
  createTheme,
} from "@material-ui/core/styles";

const useStyles = makeStyles((theme) => ({
  root: {
    maxWidth: 300,
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


export default function MenuListItems() {

  const classes = useStyles();

const[loading,setIsLoading]=useState(true);
const[ModalTitle,setModalTitle]=useState('Edit Menu');

  const [items,setitems]=useState([]);
  const [showModal,setShowModal]=useState(false);
const[rowdata,setRowdata]=useState([]);

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

  
    axiosGet('/api/getmenu')
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

  ];

  if(items && items.length >0)
  {
  items.map((item) => {
    data.push(
      columnsarray.map(function (colData) {

        return item[colData]===true?"Yes":item[colData]===false?"No":item[colData]
       
      })
    );
  });
}



return data;
 
};

const cancelModal=()=>{
  setShowModal(false);

}

const Activate=(rowid,active)=>{

  var data =    ( {"MenuId":  rowid[0],"MenuItem":rowid[1],"Description":rowid[2],"MenuItemUrl":rowid[3],"Diet":rowid[4],"Price":rowid[5],"IsActive":active,"Calories":rowid[7],"Charecterstic": rowid[8]});
  updateMenu(data)
}

const updateMenu=(data)=>{


  axiosPost('/api/updatemenu', JSON.stringify({data}))
  .then(response =>{
    fetchData();
  })
  .catch((e)=>{
    setIsLoading(false);
  })

}

const insertMenu=(data)=>{


  axiosPost('/api/insertmenu', JSON.stringify({data}))
  .then(response =>{
    fetchData();
  })
  .catch((e)=>{
    setIsLoading(false);
  })

}

const modelcallback=(returnvalues)=>{

if(ModalTitle==='Edit Menu')
{
  setShowModal(false);

  setIsLoading(true)

  updateMenu(returnvalues)  
}
else
{
  setRowdata([])
  setShowModal(false);

  setIsLoading(true)

  insertMenu(returnvalues)  

}
  
 
  

}
const handleAdd=()=>
{
  setRowdata([])

  setModalTitle('Add Menu');
setShowModal(true);
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
          <CardContent>


          <Grid container spacing={1}>
                  <Grid item sx={8}>
                              <Typography variant="body2" color="textSecondary" component="p">
                              {rowid[2]}
                              </Typography>
                  </Grid>
                  <Grid item sx={4}>
                          <CardActions >

                  <IconButton  onClick={()=>{
                      setModalTitle('Edit Menu');

                    setShowModal(true);
                    setRowdata(rowid)
                  }}>

                    <Edit /> Edit
                  </IconButton>

                  {rowid[6]==='Yes' ? <IconButton aria-label="share"   onClick={()=>{
                    Activate(rowid,0)
                  }}>
                    <Pause /> Pause
                  </IconButton>
                  :  <IconButton aria-label="share" onClick={()=>{
                  Activate(rowid,1)
                  }}>
                  <PlayArrow />Resume
                  </IconButton>
                  }

                          </CardActions>
                  </Grid>
      
          </Grid>

           
          </CardContent>
       
        
         
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
];


const options = {
 
  selectableRows: "none",
  filterType: 'dropdown',
  responsive: 'vertical',
  download: false,
  print: false,
  rowsPerPage: 10,
  selectableRowsHeader: false,
  tableBodyHeight: "1000px",

      selectableRowsOnClick: false,

      customToolbar: () => {
        return (

          <IconButton  onClick={handleAdd}>

Add Menu<Add  /> 
          </IconButton>

        );
      }
};

 

  return (

    <div className="menuList" >
   {loading &&
         <Backdrop className={classes.backdrop} open={loading} >

   <CircularProgress
                style={{ position: "absolute", top: "50%", left: "50%",zIndex :'auto'}}
              />
                    </Backdrop>}

     <EditMenu
          open={showModal}
          onClose={cancelModal}
          ModalTitle={ModalTitle}
          modelcallback={modelcallback}
          
          rowdata={rowdata}
        ></EditMenu> 
       
            <ThemeProvider theme={dataTableTheme}>
                  <MUIDataTable title={"Menu List"} data={getRows()} columns={muicolumns} options={options}  />
            </ThemeProvider>
            
    </div>
  );
}
