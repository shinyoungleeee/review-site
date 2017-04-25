import React from 'react';

class ReviewTile extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
    };
  }

  render() {
    return (
      <div className="media-object">
        <div className="media-object-section">
          <button onClick={this.props.upvoteHandler}>&#128077;</button>
          <h6>{this.props.voteCount}</h6>
          <button onClick={this.props.downvoteHandler}>&#128078;</button>
        </div>
        <div className="media-object-section">
          <p><strong>Rating: {this.props.rating}</strong></p>
          <p>{this.props.body}</p>
        </div>
      </div>
    );
  }
}

export default ReviewTile;
