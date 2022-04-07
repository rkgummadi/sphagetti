import React from "react";
import "./topbar.css";
import { NotificationsNone, Language, Settings } from "@material-ui/icons";
import logo from "./logo.jpg";


export default function Topbar() {
  return (
    <div className="topbar">
      <div className="topbarWrapper">
        <div className="topLeft">
          <span className="logo">Mr.Sphagetti</span>
        </div>
        <div className="topRight">
          <div className="topbarIconContainer">
          
          </div>
          <div className="topbarIconContainer">
          
          </div>
          <div className="topbarIconContainer">
           
          </div>
          <img src={logo} alt="" className="topAvatar"  />

        </div>
      </div>
    </div>
  );
}
