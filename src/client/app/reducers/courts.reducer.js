import { Map } from "immutable";
import { courtsConstants } from "../constants/constants";

function setState(state, newState) {
  return state.merge(newState);
}

function getCourtsStatus(state, newState) {
  const nextState = state.set(
    "courts",
    state.get("courts").merge(newState.response.data)
  );
  return nextState;
}

export function courtsReducer(state = Map(), action) {
  switch (action.type) {
    case courtsConstants.SET_STATE_COURTS_STATUS:
      return setState(state, action.state);
    case courtsConstants.GET_COURTS_STATUS_SUCCESS:
      return getCourtsStatus(state, action.payload);
    default:
      return state;
  }
}
