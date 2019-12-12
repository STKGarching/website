import { profileActions, courtsActions } from "../../actions/actions";

import { connect } from "react-redux";
import ProfileCourtsView from "./profile.courts.view";

const mapStateToProps = state => {
  return {
    profile: state.profileReducer.get("profile"),
    courts: state.courtsReducer.get("courts")
  };
};

const mapDispatchToProps = dispatch => {
  return {
    getCourtsStatus: () => {
      dispatch(courtActions.getCourtsStatus());
    }
  };
};

//export default connect(mapStateToProps, mapDispatchToProps)(TodoListComponent);
export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ProfileCourtsView);
