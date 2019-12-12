import {Map} from 'immutable';

function historyTest(state) {
    return state;
}

function submit(state, status) {
    return state.updateIn([
        'authentication', 'submitted'
    ], submitted => status);
}

export function testReducer(state = Map(), action) {
    switch (action.type) {
        case 'TEST':
            historyTest(state);
            break;
        case 'SUBMIT_TEST':
            return submit(state, action.payload);
        default:
            return state;
    }

}
