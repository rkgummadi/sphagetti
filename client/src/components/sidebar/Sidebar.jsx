import "./sidebar.css";
import {
  LineStyle,
  Timeline,
  TrendingUp,
  PermIdentity,
  Storefront,
  AttachMoney,
  BarChart,
  MailOutline,
  DynamicFeed,
  ChatBubbleOutline,
  WorkOutline,
  Report, MenuBook,

  Restaurant,
} from "@material-ui/icons";
import { Link } from "react-router-dom";

export default function Sidebar() {
  return (
    <div className="sidebar">
      <div className="sidebarWrapper">
        <div className="sidebarMenu">
          <h3 className="sidebarTitle">Dashboard</h3>
          <ul className="sidebarList">
            {/* <Link  to="/"  className="link">
            <li className="sidebarListItem ">
              <LineStyle className="sidebarIcon" />
              Customer Menu
            </li>
            </Link> */}
            <Link to="/" className="link">

            <li className="sidebarListItem">
              <Restaurant className="sidebarIcon" />
              Schedule
            </li>
            </Link>
            <Link to="/menulist" className="link">
              <li className="sidebarListItem">
                <MenuBook className="sidebarIcon" />
                Menu Items
              </li>
            </Link>

            <Link to="/menu"  target={"_blank"}   className="link">
              <li className="sidebarListItem">
                <MenuBook className="sidebarIcon" />
                Customer Menu
              </li>
            </Link>
          </ul>
        </div>
        
        <div className="sidebarMenu">
          <h3 className="sidebarTitle">Notifications</h3>
          <ul className="sidebarList">
            
            <li className="sidebarListItem">
              <DynamicFeed className="sidebarIcon" />
              Feedback
            </li>
            <li className="sidebarListItem">
              <ChatBubbleOutline className="sidebarIcon" />
              Messages
            </li>
          </ul>
        </div>
       
      </div>
    </div>
  );
}
