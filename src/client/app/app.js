import { connect } from "react-redux";
import { withRouter } from "react-router-dom";
import AppView from "./app.view";
import { appActions } from "./actions/actions";

const mapStateToProps = state => {
  return {
    profile: state.profileReducer.get("profile").toJS(),
    authentication: state.authenticationReducer.toJS()
  };
};

const mapDispatchToProps = dispatch => {
  return {
    initialPageload: () => dispatch(appActions.initialPageload()),
    historyPush: url => {
      dispatch(appActions.historyPush(url));
    }
  };
};

export default withRouter(
  connect(
    mapStateToProps,
    mapDispatchToProps
  )(AppView)
);
