//import { testActions } from "../../actions/actions";
import { connect } from "react-redux";
import AdminView from "./admin.view";

const mapStateToProps = state => {
  return { authentication: state.authenticationReducer.get("isAuthenticated") };
};

const mapDispatchToProps = dispatch => {
  return {};
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(AdminView);
