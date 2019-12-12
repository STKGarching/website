import { connect } from "react-redux";
import SubHeaderView from "./subHeader.view";

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
)(SubHeaderView);
