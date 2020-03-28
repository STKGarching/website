import React, {Component} from 'react';

export class HomeView extends Component {

    getProfile() {
        return this.props.authentication.getIn(['profile','nickname'])
    }

    render() {
        return (
            <div>
              <h1>
                Willkommen auf der Website des STK Garching!
              </h1>
              {this.props.authentication.get('isAuthenticated') && (
                <p>Hallo <b>{this.getProfile()}</b></p>
              )
              }
              {!this.props.authentication.get('isAuthenticated') && (
                <p>Du musst dich einloggen um dein Profil sehen zu können.
                </p>
              )
              }

            </div>

        )
    }

}
export default HomeView;
