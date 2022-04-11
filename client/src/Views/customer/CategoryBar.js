import React from 'react'
import "../../../node_modules/bootstrap/dist/css/bootstrap.css"

function CategoryBar() {
  //console.log("CategoryBar rendered");
    return (
        <div className="catContainer" id="categoryBar" >
        <nav className="navbar navbar-expand-lg navbar-light bg-light">
  <div className="container">
   
    <div className="collapse navbar-collapse" id="navbarNavDropdown">
      <ul className="navbar-nav">
        <li className="nav-item">
        <a className="nav-link" href="#Appetizer">Appetizer</a>
        </li>
        <li className="nav-item">
        <a className="nav-link" href="#Salad">Salad</a>
        </li>
        <li className="nav-item">
        <a className="nav-link" href="#MainCourse">MainCourse</a>
        </li>
        <li className="nav-item">
        <a className="nav-link" href="#Dessert">Dessert</a>
        </li>
       
        <li className="nav-item dropdown">
          <div className="nav-link dropdown-toggle" id="navbarDropdownMenuLink" data-bs-toggle="dropdown" role="button">
            More..
          </div>
          <ul className="dropdown-menu">
          <li><a className="dropdown-item" href="#Pizzanians">Pizzanians</a></li>
            <li><a className="dropdown-item" href="#Burgers">Burgers</a></li>
            <li><a className="dropdown-item" href="#Shakes">Shakes</a></li>
         </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>
</div>
    )
}

export default React.memo(CategoryBar)
