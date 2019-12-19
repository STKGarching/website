import axios from "axios";
import { courtsConstants } from "../constants/constants";
import * as AuthService from "../helpers/auth";

export const courtsActions = {
  getCourtsStatus
};

function getCourtsStatus() {
  const header = {
    authorization: `Bearer ${AuthService.getAccessToken()}`
  };
  const requestOptions = {
    method: "get",
    url: "https://192.168.178.32/stkapi/court_status?date=%272019-07-15%2000:00:00%27"
    //url: "https://127.0.0.1:5000/court_status?date=%272019-07-15%2000:00:00%27"
    //headers: header
  };

  const request = axios(requestOptions).then(response => {
    return { response: response, options: requestOptions };
  });
  
  return { type: courtsConstants.GET_COURTS_STATUS, payload: request };
}
