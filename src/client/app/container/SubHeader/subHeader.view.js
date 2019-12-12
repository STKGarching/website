import React, { Component } from "react";
import { Link } from "react-router-dom";

// The Header creates links that can be used to navigate
// between routes.

export class SubHeaderView extends Component {
  getItems() {
    return {
      subHeaderList: [
        {
          link: "/profile/news",
          headerText: "News",
          loginRespect: true
        },
        {
          link: "/profile/courts",
          headerText: "Plätze",
          loginRespect: true
        },
        {
          link: "/profile/team",
          headerText: "Mannschaft",
          loginRespect: true
        },
        {
          link: "/profile/work",
          headerText: "Arbeitsdienst",
          loginRespect: true
        },
        {
          link: "/profile/benefit",
          headerText: "Benefits",
          loginRespect: true
        }
      ]
    };
  }

  render() {
    return (
      <div>
        <nav>
          <ul>
            {this.getItems().subHeaderList.map(
              (item, index) =>
                item.loginRespect && (
                  <li key={item.headerText}>
                    <Link to={item.link}>{item.headerText}</Link>
                  </li>
                )
            )}
          </ul>
        </nav>
      </div>
    );
  }
}
export default SubHeaderView;
