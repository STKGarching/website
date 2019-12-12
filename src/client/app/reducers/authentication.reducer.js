import {Map} from 'immutable';
import {authenticationConstants} from '../constants/constants';
import * as AuthService from '../helpers/auth';

function setState(state, newState) {
    return state.merge(newState);
}

function loginRequest(state, newState) {
    return state.update('isFetching', isFetching => newState.isFetching).update('error', error => newState.error);
}

function loginSuccess(state, newState) {
    return state.update('isFetching', isFetching => newState.isFetching).update('isAuthenticated', isAuthenticated => newState.isAuthenticated).update('profile', profile => Map(newState.profile)).update('accessToken', accessToken => newState.accessToken);
}

function loginError(state, newState) {
    return state.update('isFetching', isFetching => newState.isFetching).update('isAuthenticated', isAuthenticated => newState.isAuthenticated).update('profile', profile => Map(newState.profile)).update('error', error => newState.error);
}

function logoutSuccess(state, newState) {
    return state.update('isAuthenticated', isAuthenticated => newState.isAuthenticated).update('profile', profile => Map(newState.profile));
}

export function authenticationReducer(state = Map(), action) {
    switch (action.type) {

        case authenticationConstants.SET_STATE_AUTH:
            return setState(state, action.state);
        case authenticationConstants.LOGIN_REQUEST:
            return loginRequest(state, {
                isFetching: true,
                error: null
            });
        case authenticationConstants.LOGIN_SUCCESS:
            return loginSuccess(state, {
                isFetching: false,
                isAuthenticated: true,
                profile: action.payload.profile,
                accessToken: action.payload.accessToken
            });
        case authenticationConstants.LOGIN_ERROR:
            return loginError(state, {
                isFetching: false,
                isAuthenticated: false,
                profile: {},
                error: action.error,
                accessToken: ''
            });
        case authenticationConstants.LOGOUT_SUCCESS:
            return logoutSuccess(state, {
                isAuthenticated: false,
                profile: {},
                accessToken: ''
            });

        default:
            return setState(state, {
                isAuthenticated: !AuthService.isTokenExpired(),
                isFetching: false,
                profile: Map(AuthService.getProfile()),
                error: null,
                accessToken: AuthService.getAccessToken()
            });
    }
};
