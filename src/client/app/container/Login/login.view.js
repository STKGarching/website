import React, {Component} from 'react';
import * as AuthService from '../../helpers/auth';

export class LoginView extends Component {
    componentWillMount() {
        // Add callback for lock's `authenticated` event
        AuthService.lock.on('authenticated', authResult => {

            AuthService.lock.getUserInfo(authResult.accessToken, (error, profile) => {

                if (error) {
                    return this.props.loginError(error);
                }
                AuthService.setToken(authResult.idToken, authResult.accessToken); // static method
                AuthService.setProfile(profile); // static method
                this.props.loginSuccess(profile, authResult.accessToken);
                this.props.historyPush('/');
                AuthService.lock.hide();
            });
        });
        // Add callback for lock's `authorization_error` event
        AuthService.lock.on('authorization_error', error => {
            this.props.loginError(error);
            this.props.historyPush('/');
        });
    }

    handleLoginClick = () => {
        AuthService.login();
        this.props.loginRequest();
    };

    handleLogoutClick = () => {
        this.props.logoutSuccess();
        AuthService.logout(); // careful, this is a static method
        this.props.historyPush('/');
    };

    render() {
        return ( < div > {
            this.props.authentication.get('isAuthenticated')
                ? (< div > < button onClick = {
                    this.handleLogoutClick
                } > Logout < /button> < /div >)
                : (< button onClick = {
                    this.handleLoginClick
                } > Login < /button>
                )
            } {
                this.props.authentication.get('error') && < p > {
                    JSON.stringify(this.props.authentication.get('error'))
                } < /p >} < /div >
            );
        }



    };

    export default LoginView
