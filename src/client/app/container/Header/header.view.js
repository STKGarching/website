import React, { Component } from "react";
import { Link } from "react-router-dom";

//import LoginComponent from './Login';
import Login from "../Login/login";

// The Header creates links that can be used to navigate
// between routes.

export class HeaderView extends Component {
  getItems() {
    return {
      headerList: [
        {
          link: "/",
          headerText: "Home",
          loginRespect: true
        },
        {
          link: "/profile/news",
          headerText: "Profil",
          loginRespect: this.props.authentication.get("isAuthenticated")
        },
        {
          link: "/info",
          headerText: "Info",
          loginRespect:true
        },
        {
          link: "/calendar",
          headerText: "Kalendar",
          loginRespect: true
        },
        {
          link: "/download",
          headerText: "Download",
          loginRespect: true
        },
        {
          link: "/contact",
          headerText: "Service & Kontakt",
          loginRespect: true
        },
        {
          link: "/settings",
          headerText: "Einstellungen",
          loginRespect: this.props.authentication.get("isAuthenticated")
        },
        {
          link: "/admin",
          headerText: "Adminbereich",
          loginRespect: this.props.authentication.get("isAuthenticated")
        }
      ]
    };
  }

  render() {
    return (
      <header>
        <nav>
          <ul>
            {this.getItems().headerList.map(
              (item, index) =>
                item.loginRespect && (
                  <li key={item.headerText}>
                    <Link to={item.link}>{item.headerText}</Link>
                  </li>
                )
            )}
          </ul>
        </nav>

        <div>
          <Login />
        </div>
      </header>
    );
  }
}
export default HeaderView;
