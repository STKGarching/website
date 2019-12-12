import React from 'react';
import { Route, Redirect } from 'react-router-dom';
import * as AuthService from '../../helpers/auth';

export const PrivateRoute = ({ component: Component, ...rest }) => (
    <Route {...rest} render={props => (
      localStorage.getItem('profile') && !AuthService.isTokenExpired()
        ? <Component {...props} />
        : <Redirect to={{ pathname: '/', state: { from: props.location } }} />
    )} />
)
