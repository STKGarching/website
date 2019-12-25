import { Map } from "immutable";
import { authenticationConstants, profileConstants, profileLandingPages } from "../constants/constants";

function setState(state, newState) {
  return state.merge(newState);
}

function setProfileInfo(state, newState) {
  const roles = [];
  console.log(newState.response.data)
  newState.response.data.forEach(item => {
    roles.push(item.role);
  });
  const profile = {
    personNumber: newState.response.data[0].person_no,
    firstName: newState.response.data[0].first_name,
    lastName: newState.response.data[0].last_name,
    member_no: newState.response.data[0].member_no,
    roles: roles
  };
  const nextState = state.set("profile", state.get("profile").merge(profile));
  return nextState
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
    case authenticationConstants.GET_PROFILE_INFO_FULFILLED:
      return setProfileInfo(state, action.payload);
    case profileConstants.SET_LANDING_PAGE:
      return setLandingPage(state, action.state);
    case profileConstants.INITIAL_PAGE_LOAD:
      return initialPageload(state, action.payload);
    default:
      return state;
  }
}
