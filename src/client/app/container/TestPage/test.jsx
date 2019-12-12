import {testActions} from '../../actions/actions';
import {connect} from 'react-redux';
import TestPageView from './test.view';

const mapStateToProps = (state) => {
    return {authentication: state.testReducer.get('authentication')};

}

const mapDispatchToProps = (dispatch) => {
    console.log('dispactch')
    return {
        historyTest: () => {
            dispatch(testActions.historyTest());
        },
        submit: (status) => {
            dispatch(testActions.submit(status));
        }
    }
}

export default connect(mapStateToProps, mapDispatchToProps)(TestPageView);
