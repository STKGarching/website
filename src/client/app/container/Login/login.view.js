import React, { Component } from "react";
import * as AuthService from "../../helpers/auth";
import moment from "moment";

export class LoginView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      remainingLoginTime: -1,
      remainingLoginTimeUpdate: false,
      curTime: null
    };
  }

  componentDidMount() {
    // Add callback for lock's `authenticated` event
    AuthService.lock.on("authenticated", authResult => {
      AuthService.lock.getUserInfo(authResult.accessToken, (error, profile) => {
        if (error) {
          return this.props.loginError(error);
        }
        AuthService.setToken(authResult.idToken, authResult.accessToken); // static method
        const memberNo = AuthService.getTokenMemberNo()
        profile['memberNo'] = memberNo
        AuthService.setProfile(profile); // static method
        this.props.loginSuccess(profile, authResult.accessToken);
        this.props.historyPush("/");
        AuthService.lock.hide();
      });
    });
    // Add callback for lock's `authorization_error` event
    AuthService.lock.on("authorization_error", error => {
      this.props.loginError(error);
      this.props.historyPush("/");
    });

    setInterval(() => {
      this.setState({
        curTime: moment(),
        remainingLoginTime: this.handleLoginTime(),
        remainingLoginTimeUpdate: true
      });
    }, 1000);
  }

  componentDidUpdate(prevProps, prevState) {
    if (
      moment(this.state.remainingLoginTime).unix() < 0 &&
      this.props.authentication.isAuthenticated &&
      this.state.remainingLoginTimeUpdate
    ) {
      // automatic logout when token expires.
      this.handleLogoutClick();
    }
  }

  handleLoginTime = () => {
    return moment.utc(
      moment
        .duration(
          moment(moment.unix(this.props.authentication.expiryDate)).diff(
            moment()
          )
        )
        .asMilliseconds()
    );
  };

  handleLoginClick = () => {
    AuthService.login();
    this.props.loginRequest();
  };

  handleLogoutClick = () => {
    this.props.logoutSuccess();
    AuthService.logout(); // careful, this is a static method
    this.props.historyPush("/");
  };

  render() {
    return (
      <div>
        <div>
          {" "}
          {this.props.authentication.isAuthenticated ? (
            <div>
              {" "}
              <button onClick={this.handleLogoutClick}> Logout </button>{" "}
            </div>
          ) : (
            <button onClick={this.handleLoginClick}> Login </button>
          )}{" "}
          {this.props.authentication.error && (
            <p> {JSON.stringify(this.props.authentication.error)} </p>
          )}{" "}
        </div>
        {this.props.authentication.isAuthenticated && (
          <p>
            verbleibende Loginzeit:
            {this.state.remainingLoginTime < 0
              ? "n/a"
              : this.state.remainingLoginTime.format("HH:mm:ss")}
          </p>
        )}
      </div>
    );
  }
}

export default LoginView;
