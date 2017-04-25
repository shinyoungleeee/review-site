import React from 'react';

class ReviewTile extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
    };
  }

  render() {
    let editOrDelete = () => {
      if (this.props.currentUser) {
        return(
          <div className="media-object-section">
            <div className="button-group">
              <a className="secondary button" href={`/memes/${this.props.memeId}/reviews/${this.props.id}/edit`}>Edit Review</a>
              <button className="alert button" onClick={this.props.deleteHandler}>Delete Review</button>
            </div>
          </div>
        )
      }
    };
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
        {editOrDelete()}
      </div>
    );
  }
}

export default ReviewTile;
