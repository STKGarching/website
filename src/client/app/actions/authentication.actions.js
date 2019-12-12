import {authenticationConstants} from '../constants/constants';
import {history} from '../helpers/helpers';

export const authenticationActions = {
    loginRequest,
    loginSuccess,
    loginError,
    logoutSuccess,
    historyPush
};

function loginRequest() {
    return {type: authenticationConstants.LOGIN_REQUEST}
};

function loginSuccess(profile,accessToken) {
    return {type: authenticationConstants.LOGIN_SUCCESS, payload: {profile: profile, accessToken: accessToken}}
};

function loginError(error) {
    return {type: authenticationConstants.LOGIN_ERROR, error}
};

function logoutSuccess() {
    return {type: authenticationConstants.LOGOUT_SUCCESS}
};

function historyPush(url) {
    history.push(url)
    return {type: authenticationConstants.HISTORY, payload: {}};
}
