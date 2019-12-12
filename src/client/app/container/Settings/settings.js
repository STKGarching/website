//import {testActions} from '../../actions/actions';
import { connect } from "react-redux";
import SettingsView from "./settings.view";

const mapStateToProps = state => {
  return { authentication: state.testReducer.get("authentication") };
};

const mapDispatchToProps = dispatch => {};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(SettingsView);
