import { profileActions, courtsActions } from "../../actions/actions";

import { connect } from "react-redux";
import ProfileCourtsView from "./profile.courts.view";

const mapStateToProps = state => {
  return {
    profile: state.profileReducer.get("profile").toJS(),
    courts: state.courtsReducer.get("courts").toJS(),
    courtStatusList: state.courtsReducer.get("courtStatusList").toJS()
  };
};

const mapDispatchToProps = dispatch => {
  return {
    getCourtStatusList: () => {
      dispatch(courtsActions.getCourtStatusList());
    },
    getCourtsStatus: () => {
      dispatch(courtsActions.getCourtsStatus());
    },
    setCourtsStatus: (
      courtId,
      courtStatusListId,
      courtStatusName,
      personNumber
    ) => {
      dispatch(
        courtsActions.setCourtsStatus(
          courtId,
          courtStatusListId,
          courtStatusName,
          personNumber
        )
      );
    }
  };
};

//export default connect(mapStateToProps, mapDispatchToProps)(TodoListComponent);
export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ProfileCourtsView);
