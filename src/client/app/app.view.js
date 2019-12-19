import React, { Component } from "react";
//import Content from './component/Content';
import Header from "./container/Header/header";
import Main from "./component/main";
import { history } from "./helpers/helpers";
import * as AuthService from "./helpers/auth";

export class AppView extends Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  componentDidMount() {
    console.log(this.props.authentication);
    // First website loading should lead directly to landing page according to settings
    if (
      this.props.profile.initialPageload &&
      this.props.authentication.isAuthenticated
    ) {
      this.props.initialPageload();
      this.props.historyPush(this.props.profile.landingPage);
    }
  }

  render() {
    return (
      <div>
        <Header />
        <Main />
      </div>
    );
  }
}

export default AppView;
