import axios from "axios";
import { courtsConstants, baseURL_REST_API } from "../constants/constants";
import * as AuthService from "../helpers/auth";
import moment from "moment";

export const courtsActions = {
  getCourtStatusList,
  getCourtsStatus,
  setCourtsStatus
};

function getCourtStatusList() {
  const header = {
    authorization: `Bearer ${AuthService.getAccessToken()}`
  };
  const requestOptions = {
    method: "get",
    url: baseURL_REST_API + `court_status_list`
  };

  const request = axios(requestOptions).then(response => {
    return { response: response, options: requestOptions };
  });

  return { type: courtsConstants.GET_COURT_STATUS_LIST, payload: request };
}

function getCourtsStatus() {
  var now = moment();
  const header = {
    authorization: `Bearer ${AuthService.getAccessToken()}`
  };
  const requestOptions = {
    method: "get",
    url:
      baseURL_REST_API +
      `get_court_status?date=%27${now.format("YYYY-MM-DD")}%20${now.format(
        "HH:mm:ss"
      )}%27`
    //url: "https://192.168.178.44/stkapi/court_status?date=%272019-07-15%2000:00:00%27"
    //url: "https://127.0.0.1:5000/court_status?date=%272019-07-15%2000:00:00%27"
    //headers: header
  };
  console.log(requestOptions)

  const request = axios(requestOptions).then(response => {
    return { response: response, options: requestOptions };
  });

  return { type: courtsConstants.GET_COURTS_STATUS, payload: request };
}

function setCourtsStatus(
  courtId,
  courtStatusListId,
  courtStatusName,
  personNumber
) {
  var now = moment();
  var infinity = moment("9999-12-31 23:59:59 ");
  const header = {
    authorization: `Bearer ${AuthService.getAccessToken()}`
  };
  const requestOptions = {
    method: "get",
    url:
      baseURL_REST_API +
      `court_status/update?court_id=${courtId}&court_status_list_id=${courtStatusListId}&valid_from=%27${now.format(
        "YYYY-MM-DD"
      )}%20${now.format("HH:mm:ss")}%27&valid_to=%27${infinity.format(
        "YYYY-MM-DD"
      )}%20${infinity.format("HH:mm:ss")}%27&changed_by=${personNumber}`
  };

  const request = axios(requestOptions).then(response => {
    return { response: response, options: requestOptions };
  });

  return {
    type: courtsConstants.SET_COURTS_STATUS,
    payload: { court_id: courtId, court_status_name: courtStatusName }
  };
}
