import { combineReducers } from "redux";
import { testReducer } from "./test.reducer";
import { authenticationReducer } from "./authentication.reducer";
import { racketlistReducer } from "./racketlist.reducer";

const rootReducer = combineReducers({
  authenticationReducer,
  profileReducer,
  courtReducer
});

export default rootReducer;
