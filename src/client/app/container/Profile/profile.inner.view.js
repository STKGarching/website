import React, { Component } from "react";
import { Switch, Route } from "react-router-dom";

import ProfileNews from "./profile.news";
import ProfileCourts from "./profile.courts";
import ProfileTeam from "./profile.team";
import ProfileWork from "./profile.work";
import ProfileBenefit from "./profile.benefit";
import SubHeader from "../SubHeader/subHeader";

import { PrivateRoute } from "../../component/extensions/privateRoute";
//<Route exact path='/' component={Home}/>
export class InnerProfile extends Component {
  /*
  render() {
    return (
      <div>
        <h1>TEst Profile</h1>
      </div>
    );
  }
  */
  render() {
    return (
      <div>
        {" "}
        <Switch>
          {" "}
          <PrivateRoute
            exact
            path="/profile/news"
            component={ProfileNews}
          />{" "}
          <PrivateRoute
            exact
            path="/profile/courts"
            component={ProfileCourts}
          />{" "}
          <PrivateRoute exact path="/profile/team" component={ProfileTeam} />{" "}
          <PrivateRoute exact path="/profile/work" component={ProfileWork} />{" "}
          <PrivateRoute
            exact
            path="/profile/benefit"
            component={ProfileBenefit}
          />{" "}
        </Switch>
      </div>
    );
  }
}
export default InnerProfile;
