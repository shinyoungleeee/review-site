import React from 'react';

class ReviewTile extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
    };
  }

  render() {
    let editOrDelete = () => {
      if (this.props.belongsToCurrentUser || this.props.admin) {
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
      <div className="row">
        <div className="small-1 columns text-center">
          <button onClick={this.props.upvoteHandler}>&#128077;</button>
          <h6>{this.props.voteCount}</h6>
          <button onClick={this.props.downvoteHandler}>&#128078;</button>
        </div>
        <div className="small-1 columns text-center rating">
          <p><strong>{this.props.rating}</strong></p>
          <p><strong>RATING</strong></p>
        </div>
        <div className="small-7 columns">
          <p><strong>{this.props.author}: </strong>{this.props.body}</p>
        </div>
        <div className="small-3 columns">
          {editOrDelete()}
        </div>
      </div>
    );
  }
}

export default ReviewTile;
