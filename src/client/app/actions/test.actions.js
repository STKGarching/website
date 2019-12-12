import { history } from '../helpers/helpers';

export const testActions = {
  historyTest,
  submit
};

function historyTest() {
    history.push('/');
    return { type: 'TEST', payload: {} };
}

function submit(status) {
    return {type: 'SUBMIT_TEST', payload: status};
}
