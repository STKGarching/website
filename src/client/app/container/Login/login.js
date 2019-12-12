import {authenticationActions} from '../../actions/actions';
import {connect} from 'react-redux';
import LoginView from './login.view';

const mapStateToProps = (state) => {
    return {authentication: state.authenticationReducer};
}

const mapDispatchToProps = (dispatch) => {

    return {
        loginSuccess: (profile, accessToken) => dispatch(authenticationActions.loginSuccess(profile, accessToken)),
        loginError: error => dispatch(authenticationActions.loginError(error)),
        loginRequest: () => dispatch(authenticationActions.loginRequest()),
        logoutSuccess: () => dispatch(authenticationActions.logoutSuccess()),
        historyPush: (url) => {
            dispatch(authenticationActions.historyPush(url));
        }
    }

}

export default connect(mapStateToProps, mapDispatchToProps)(LoginView);
