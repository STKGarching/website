import { Map } from "immutable";
import { courtsConstants } from "../constants/constants";

function setState(state, newState) {
  return state.merge(newState);
}

function getCourtStatusList(state, newState) {
  const nextState = state.set(
    "courtStatusList",
    state.get("courtStatusList").merge(newState.response.data)
  );
  return nextState;
}

function getCourtsStatus(state, newState) {
  const nextState = state.set(
    "courts",
    state.get("courts").merge(newState.response.data)
  );
  return nextState;
}

function setCourtStatus(state, newState) {
  const nextState = state.set(
    "courts",
    state
      .get("courts")
      .setIn(
        [
          state
            .get("courts")
            .findIndex(i => i.get("court_id") === newState.court_id),
          "court_status_name"
        ],
        newState.court_status_name
      )
  );
  return nextState;
}

export function courtsReducer(state = Map(), action) {
  switch (action.type) {
    case courtsConstants.SET_STATE_COURTS_STATUS:
      return setState(state, action.state);
    case courtsConstants.GET_COURTS_STATUS_FULFILLED:
      return getCourtsStatus(state, action.payload);
    case courtsConstants.GET_COURT_STATUS_LIST_FULFILLED:
      return getCourtStatusList(state, action.payload);
    // TODO: Eigentlich sollte es so sein, dass SET_COURTS_STATUS_FULFILLED kommt, damit man sicher sein kann, dass die Datenbank ein Update hatte.
    case courtsConstants.SET_COURTS_STATUS:
      return setCourtStatus(state, action.payload);
    default:
      return state;
  }
}
