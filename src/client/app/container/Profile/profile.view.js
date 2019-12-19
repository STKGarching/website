import React, { Component } from "react";
import { Switch, Route } from "react-router-dom";

import InnerProfile from "./profile.inner.view";
import SubHeader from "../SubHeader/subHeader";

//<Route exact path='/' component={Home}/>
export class Profile extends Component {
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
        <InnerProfile />
        <SubHeader />
      </div>
    );
  }
}
export default Profile;
