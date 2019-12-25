import { authenticationActions } from "../../actions/actions";
import { connect } from "react-redux";
import LoginView from "./login.view";

const mapStateToProps = state => {
  return {
    authentication: state.authenticationReducer.toJS(),
    profile: state.profileReducer.get("profile").toJS()
  };
};

const mapDispatchToProps = dispatch => {
  return {
    getProfileInfo: personNumber =>
      dispatch(authenticationActions.getProfileInfo(personNumber)),
    loginSuccess: (profile, accessToken) =>
      dispatch(authenticationActions.loginSuccess(profile, accessToken)),
    loginError: error => dispatch(authenticationActions.loginError(error)),
    loginRequest: () => dispatch(authenticationActions.loginRequest()),
    logoutSuccess: () => dispatch(authenticationActions.logoutSuccess()),
    historyPush: url => {
      dispatch(authenticationActions.historyPush(url));
    }
  };
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(LoginView);
