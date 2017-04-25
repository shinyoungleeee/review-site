import React from 'react';

class ReviewTile extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
    };
  }

  render() {
    return (
      <div>
        <p><strong>Rating: {this.props.rating}</strong></p>
        <p>{this.props.body}</p>
        <button onClick={this.props.upvoteHandler}>Upvote</button>
        <h6>{this.props.voteCount}</h6>
        <button onClick={this.props.downvoteHandler}>Downvote</button>
      </div>
    );
  }
}

export default ReviewTile;
