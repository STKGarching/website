import { Map } from "immutable";
import { profileConstants, profileLandingPages } from "../constants/constants";

function setState(state, newState) {
  return state.merge(newState);
}

function setLandingPage(state, newState) {
  const nextState = state.set("profile", state.get("profile").merge(newState));
  return nextState;
}

function initialPageload(state, newState) {
  const nextState = state.set("profile", state.get("profile").merge(newState));
  return nextState;
}

export function profileReducer(state = Map(), action) {
  switch (action.type) {
    case profileConstants.SET_STATE_PROFILE:
      return setState(state, action.state);
    case profileConstants.SET_LANDING_PAGE:
      return setLandingPage(state, action.state);
    case profileConstants.INITIAL_PAGE_LOAD:
      return initialPageload(state, action.payload);
    default:
      return state;
  }
}
