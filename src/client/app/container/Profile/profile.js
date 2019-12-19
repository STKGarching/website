import { racketlistActions } from "../../actions/actions";
import { connect } from "react-redux";
import ProfileView from "./profile.view";

const mapStateToProps = state => {
  return {};
};

const mapDispatchToProps = dispatch => {
  return {};
};

//export default connect(mapStateToProps, mapDispatchToProps)(TodoListComponent);
export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ProfileView);
