import { Map } from "immutable";
import { profileConstants } from "../constants/constants";

export function profileReducer(state = Map(), action) {
  switch (action.type) {
    case profileConstants.SET_STATE_PROFILE:
      return setState(state, action.state);
    default:
      return state;
  }
}
