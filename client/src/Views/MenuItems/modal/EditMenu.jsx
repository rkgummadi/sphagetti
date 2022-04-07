import {
  
  Publish,
} from "@material-ui/icons";
import "./EditMenu.css";
import React, { useEffect } from "react";


import {Dialog,
  Button,
  
  Slide
  //FormHelperText,
} from "@material-ui/core";


const Transition = React.forwardRef(function Transition(props, ref) {
  return <Slide direction="up" ref={ref} {...props} />;
});

export default function EditMenu(props) {


  

  const [propEdit, setPropsEdit] = React.useState({});
  const handleclick=()=>{

  
    props.modelcallback(
      propEdit
    );

  }

  useEffect(() => {
    

    setPropsEdit( {"MenuId":  props.rowdata[0],"MenuItem":props.rowdata[1],"Description":props.rowdata[2],"MenuItemUrl":props.rowdata[3],"Diet":props.rowdata[4],"Price":props.rowdata[5],"IsActive":props.rowdata[6]==='Yes'?1:0,"Calories":props.rowdata[7],"Charecterstic": props.rowdata[8]});
  }, [props.rowdata]);
  return (
    <Dialog
    maxWidth="md"
    style={{ maxHeight: "800px" }}
    open={props.open}
    TransitionComponent={Transition}
    keepMounted={false}
    onClose={props.onClose}
  >
    <div className="user">
      <div className="userTitleContainer">
        <h1 className="userTitle">{props.ModalTitle}</h1>
        
      </div>
      <div className="userContainer">
      
        <div className="userUpdate">
          <form className="userUpdateForm">
            <div className="userUpdateLeft">
              <div className="userUpdateItem">
                <label>Menu Name</label>
                <input
                  type="text"
                 defaultValue={propEdit["MenuItem"]}
                 onChange={event => setPropsEdit({...propEdit,MenuItem:event.target.value})}

                  className="userUpdateInput"
                />

                
              </div>
              <div className="userUpdateItem">
                <label>Url</label>
                <input
                  type="text"
                  id='menurl'
                  className="userUpdateInput"
                  defaultValue={propEdit["MenuItemUrl"]}
                  onChange={event => setPropsEdit({...propEdit,MenuItemUrl:event.target.value})}

                />
              </div>
              <div className="userUpdateItem">
                <label>Description </label>
                <input
                  type="text"
                  defaultValue={propEdit["Description"]}
                  className="userUpdateInput"
                  onChange={event => setPropsEdit({...propEdit,Description:event.target.value})}

                />
              </div>
              <div className="userUpdateItem">
                <label>Price </label>
                <input
                  type="text"
                  placeholder="$"
                  className="userUpdateInput"
                  defaultValue={ propEdit["Price"]?"$"+Number(propEdit["Price"]):''}
                  onChange={event => setPropsEdit({...propEdit,Price:event.target.value})}


                />
              </div>
              <div className="userUpdateItem">
                <label>Diet</label>
                <input
                  type="text"
                  defaultValue={ propEdit["Diet"]}
                  onChange={event => setPropsEdit({...propEdit,Diet:event.target.value})}

                  className="userUpdateInput"
                />
              </div>
              <div className="userUpdateItem">
               
              </div>

              <div className="userUpdateItem">
                <label>Calories</label>
                <input
                  type="text"
                  defaultValue={ propEdit["Calories"]}
                  onChange={event => setPropsEdit({...propEdit,Calories:event.target.value})}

                  className="userUpdateInput"
                />
              </div>
              <div className="userUpdateItem">
                <label>Charecterstic</label>
                <input
                  type="text"
                  defaultValue={ propEdit["Charecterstic"]}
                  onChange={event => setPropsEdit({...propEdit,Charecterstic:event.target.value})}

                  className="userUpdateInput"
                />
              </div>
            </div>
            <div className="userUpdateRight">
         
              <div className="userUpdateUpload">
                <img
                  className="userUpdateImg"
                  src={ propEdit["MenuItemUrl"]}
                  alt=""
                />
                <label htmlFor="file">
                  <Publish className="userUpdateIcon" />
                </label>
                <input type="file" id="file" style={{ display: "none" }} />
              </div>
              <Button          color="primary" variant="contained" onClick={handleclick}>{props.ModalTitle==='Edit Menu'?'Update':'Add'}</Button>
            </div>
          </form>
        </div>
      </div>
    </div>

    </Dialog>

  );
}
