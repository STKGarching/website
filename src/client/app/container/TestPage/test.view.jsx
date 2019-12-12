import React, {Component} from 'react';
import * as AuthService from '../../helpers/auth';

export class TestPageView extends Component {

    componentDidMount() {
        //console.log('begin');
        //console.log(this.props);
        //console.log('end');
    }

    myButton() {
        console.log({localStorage});
    }

    myAuthService() {
      const tester = AuthService.getTokenExpirationDate();
        console.log(tester);

    }
    showState() {
      console.log(this.props);
      console.log(this.props.authentication);
      console.log(this.props.authentication.get('submitted'));
    }

    render() {
        return <section>
          <div>
            <h1>Test Seite</h1>
            <div>Diese Seite nutze ich um verschiedene Dinge zu testen. Der Test Button macht einen history push nach '/'</div>
            <button onClick={() => this.props.historyTest()}>Test Button</button>
            <div>mit dem nachfolgenden Button möchte ich den LcoalStorage untersuchen</div>
            <button onClick={() => this.myButton()}>Lokaler BuUtton</button>
            <div>mit dem nachfolgenden Button möchte ich den AUth Token untersuchen</div>
            <button onClick={() => this.myAuthService()}>Auth BuUtton</button>
            <div>mit dem nachfolgenden Button kann man den State betrachten</div>
            <button onClick={() => this.showState()}>State</button>
            <div>Submit Test</div>
            <button onClick={() => this.props.submit(true)}>Submit aendern</button>
          </div>
        </section>
    }
};

export default TestPageView;
