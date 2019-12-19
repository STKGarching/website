import { profileConstants } from "../constants/constants";
import { history } from "../helpers/helpers";

export const appActions = {
  initialPageload,
  historyPush
};

function initialPageload() {
  return {
    type: profileConstants.INITIAL_PAGE_LOAD,
    payload: { initialPageload: false }
  };
}

function historyPush(url) {
  history.push(url);
  return { type: profileConstants.HISTORY, payload: {} };
}
