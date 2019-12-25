import axios from "axios";
import {
  authenticationConstants,
  baseURL_REST_API
} from "../constants/constants";
import * as AuthService from "../helpers/auth";
import { history } from "../helpers/helpers";

export const authenticationActions = {
  getProfileInfo,
  loginRequest,
  loginSuccess,
  loginError,
  logoutSuccess,
  historyPush
};

function getProfileInfo(person_no) {
  const header = {
    authorization: `Bearer ${AuthService.getAccessToken()}`
  };
  const requestOptions = {
    method: "get",
    url: baseURL_REST_API + `person_info?person_no=${person_no}`
  };

  const request = axios(requestOptions).then(response => {
    return { response: response, options: requestOptions };
  });
  return { type: authenticationConstants.GET_PROFILE_INFO, payload: request };
}

function loginRequest() {
  return { type: authenticationConstants.LOGIN_REQUEST };
}

function loginSuccess(profile, accessToken) {
  return {
    type: authenticationConstants.LOGIN_SUCCESS,
    payload: { profile: profile, accessToken: accessToken }
  };
}

function loginError(error) {
  return { type: authenticationConstants.LOGIN_ERROR, error };
}

function logoutSuccess() {
  return { type: authenticationConstants.LOGOUT_SUCCESS };
}

function historyPush(url) {
  history.push(url);
  return { type: authenticationConstants.HISTORY, payload: {} };
}
