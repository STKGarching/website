import { profileActions } from "../../actions/actions";
import { connect } from "react-redux";
import ProfileTeamView from "./profile.team.view";

const mapStateToProps = state => {
  return {
    profile: state.profileReducer.get("profile")
  };
};

const mapDispatchToProps = dispatch => {
  return {};
};

//export default connect(mapStateToProps, mapDispatchToProps)(TodoListComponent);
export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ProfileTeamView);
