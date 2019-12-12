import { racketlistActions } from '../../actions/actions';
import {connect} from 'react-redux';
import RacketListView from './racketlist.view';

const mapStateToProps = (state) => {
  return {
    rackets: state.racketlistReducer.get('rackets'),
  };
}

const mapDispatchToProps = (dispatch) => {

  return {
    getRacketList: () => {
      dispatch(racketlistActions.getRacketList());
    },
    registerNewRacket: (name,manufacturer,release_year) => {
      dispatch(racketlistActions.registerNewRacket(name,manufacturer,release_year));
    }
  }
}

//export default connect(mapStateToProps, mapDispatchToProps)(TodoListComponent);
export default connect(mapStateToProps, mapDispatchToProps)(RacketListView);
