import { combineReducers } from "redux";
import { profileReducer } from "./profile.reducer";
import { authenticationReducer } from "./authentication.reducer";
import { courtsReducer } from "./courts.reducer";

const rootReducer = combineReducers({
  authenticationReducer,
  profileReducer,
  courtsReducer
});

export default rootReducer;
