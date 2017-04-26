import React from 'react';
import { Router, Route, browserHistory } from 'react-router';
import MemesIndexContainer from './containers/MemesIndexContainer'
import MemesShowContainer from './containers/MemesShowContainer'

class Root extends React.Component {
  constructor(props){
    super(props)
    this.state = {
    }
  }

  render() {
    return(
      <Router history={browserHistory}>
        <Route path='/' >
          <Route path='memes' component={MemesIndexContainer} />
          <Route path='memes/:memeId' component={MemesShowContainer} />
        </Route>
      </Router>
    )
  }
}

export default Root;
