import React from "react";
import ReactDOM from "react-dom";
import { Router } from "react-router-dom";
import { compose, createStore, applyMiddleware } from "redux";
import { Provider } from "react-redux";
import promiseMiddleware from "redux-promise-middleware";
import thunkMiddleware from "redux-thunk";
import rootReducer from "./reducers/reducer";
import "./index.css";
import AppContainer from "./app";
import { history } from "./helpers/helpers";
import { profileLandingPages } from "./constants/constants";
//import registerServiceWorker from "./registerServiceWorker";

const store = createStore(
  rootReducer,
  compose(
    applyMiddleware(promiseMiddleware(), thunkMiddleware),
    window.devToolsExtension ? window.devToolsExtension() : f => f
  )
);

// ----------------------
// FAKE IT TILL YOU MAKE IT
//https://www.jsonwebtoken.io/
const fakeidToken =
  "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWUsImp0aSI6IjY1YjQ3MGRjLTcyMjQtNDhmOC1hZmIyLTNlMTM0Y2FhYTZlNSIsImlhdCI6MTY1NjIyMjcwOSwiZXhwIjoxNTc2NjAwNjk1fQ.oDotcaIgiCj0TaVA_exY9ZPrv3GatUn5x5pXbVJQtNE";
//window.localStorage.setItem("id_token", fakeidToken);
const fakeProfile = {};
//window.localStorage.setItem("profile", fakeProfile);
// ----------------------

store.dispatch({
  type: "SET_STATE_COURTS_STATUS",
  state: {
    courts: [],
    courtStatusList: []
  }
});

store.dispatch({
  type: "SET_STATE_PROFILE",
  state: {
    profile: {
      personNumber: null,
      firstName: "",
      lastName: "",
      member_no: null,
      roles: [],
      initialPageload: true,
      landingPage: "/"
    }
  }
});

ReactDOM.render(
  <Provider store={store}>
    <Router history={history}>
      <AppContainer />
    </Router>
  </Provider>,
  document.getElementById("root")
);
//registerServiceWorker();
