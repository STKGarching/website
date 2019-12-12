import React from "react";
import ReactDOM from "react-dom";
import { Router } from "react-router-dom";
import { compose, createStore, applyMiddleware } from "redux";
import { Provider } from "react-redux";
import promiseMiddleware from "redux-promise-middleware";
import thunkMiddleware from "redux-thunk";
import rootReducer from "./reducers/reducer";
import "./index.css";
import { AppContainer } from "./App";
import { history } from "./helpers/helpers";
//import registerServiceWorker from "./registerServiceWorker";

const store = createStore(
  rootReducer,
  compose(
    applyMiddleware(promiseMiddleware(), thunkMiddleware),
    window.devToolsExtension ? window.devToolsExtension() : f => f
  )
);

store.dispatch({
  type: "SET_STATE_COURTS_STATUS",
  state: {
    courts: [
      {
        court_no: 1,
        court_type: "Freiplatz",
        court_surface: "Sand",
        court_status_name: "Bespielbar"
      }
    ]
  }
});

store.dispatch({
  type: "SET_STATE_PROFILE",
  state: {
    profile: {
      role: "admin"
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
