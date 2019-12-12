import { connect } from "react-redux";
import HeaderView from "./header.view";

const mapStateToProps = state => {
  return {
    authentication: state.authenticationReducer
  };
};

const mapDispatchToProps = dispatch => {
  return {};
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(HeaderView);
