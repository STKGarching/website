import {connect} from 'react-redux';
import HomeView from './home.view';

const mapStateToProps = (state) => {
    return {authentication: state.authenticationReducer};
}

const mapDispatchToProps = (dispatch) => {
    return {}
}

export default connect(mapStateToProps, mapDispatchToProps)(HomeView);
