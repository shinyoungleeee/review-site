import React from 'react';
import { Link } from 'react-router';

class MemesIndexContainer extends React.Component {
  constructor(props){
    super(props)
    this.state = {
    }
  }

  render() {
    return(
      <div>
        {this.props.children}
      </div>
    )
  }
}

export default MemesIndexContainer;
