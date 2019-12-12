import React, {Component} from 'react';
//import Content from './component/Content';
import Header from './container/Header/header';
import Main from './component/main';

export class App extends Component {
    render() {
        return (
            <div>
              <Header/>
              <Main/>
            </div>

        );
    }
}

export const AppContainer = App;
