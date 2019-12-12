import React, { Component } from "react";
import { Switch, Route } from "react-router-dom";

import Home from "../container/Home/home";
import Profile from "../container/Profile/profile";
import Info from "./info";
import Calendar from "./calendar";
import Download from "./download";
import Contact from "./contact";
import Settings from "../container/Profile/settings";
import Admin from "../container/Profile/admin";
import Callback from "./callback";
import { PrivateRoute } from "./extensions/privateRoute";
//<Route exact path='/' component={Home}/>
export class Main extends Component {
  render() {
    return (
      <div>
        {" "}
        <Switch>
          {" "}
          <Route exact path="/" component={Home} />{" "}
          <PrivateRoute exact path="/profile" component={Profile} />{" "}
          <Route exact path="/info" component={Info} />{" "}
          <Route exact path="/calendar" component={Calendar} />{" "}
          <Route exact path="/download" component={Download} />{" "}
          <Route exact path="/contact" component={Contact} />{" "}
          <PrivateRoute exact path="/settings" component={Settings} />{" "}
          <PrivateRoute exact path="/admin" component={Admin} />{" "}
          <Route exact path="/callback" component={Callback} />{" "}
        </Switch>
      </div>
    );
  }
}
export default Main;
