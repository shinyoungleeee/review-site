import React from 'react';
import { Link } from 'react-router';
import ReviewTile from '../components/ReviewTile'

class MemesShowContainer extends React.Component {
  constructor(props){
    super(props)
    this.state = {
      reviews: []
    };

    this.updateReviewVote = this.updateReviewVote.bind(this)
    this.deleteReview = this.deleteReview.bind(this)
  }

  componentDidMount() {
    fetch(`/memes/${this.props.params.memeId}/api/reviews.json`, {credentials: 'same-origin'})
      .then(response => {
        if (response.ok) {
          return response;
        } else {
          let errorMessage = `${response.status} (${response.statusText})`,
              error = new Error(errorMessage);
          throw(error);
        }
      })
      .then(response => response.json())
      .then(body => {
        this.setState({ reviews: body });
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

  updateReviewVote(review_id, upvote) {
    let votePayload = {
      review_vote: {
        review_id: review_id,
        upvote: upvote
      }
    }
    fetch(`/memes/${this.props.params.memeId}/api/reviews.json`, {
      credentials: 'same-origin',
      method: 'PATCH',
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(votePayload)
    })
    .then(response => {
      if (response.ok) {
        return response;
      } else {
        let errorMessage = `${response.status} (${response.statusText})`,
            error = new Error(errorMessage);
        throw(error);
      }
    })
    .then(response => response.json())
    .then(body => {
      this.setState({ reviews: body });
    })
    .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

  deleteReview(review_id) {
    let deletePayload = {
      delete_review: {
        review_id: review_id
      }
    }
    if (confirm("Are you sure?")) {
      fetch(`/memes/${this.props.params.memeId}/api/reviews.json`, {
        credentials: 'same-origin',
        method: 'DELETE',
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(deletePayload)
      })
      .then(response => {
        if (response.ok) {
          return response;
        } else {
          let errorMessage = `${response.status} (${response.statusText})`,
              error = new Error(errorMessage);
          throw(error);
        }
      })
      .then(response => response.json())
      .then(body => {
        this.setState({ reviews: body });
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`));
    }
  }

  render() {
    let reviews = this.state.reviews.map(review => {
      let upvoteHandler = () => {
        this.updateReviewVote(review.id, true)
      }
      let downvoteHandler = () => {
        this.updateReviewVote(review.id, false)
      }
      let deleteHandler = () => {
        this.deleteReview(review.id)
      }
      return(
        <ReviewTile
          key={review.id}
          id={review.id}
          rating={review.rating}
          body={review.body}
          voteCount={review.vote_count}
          upvoteHandler={upvoteHandler}
          downvoteHandler={downvoteHandler}
          memeId={this.props.params.memeId}
          deleteHandler={deleteHandler}
          currentUser={review.current_user}
        />
      )
    })
    return(
      <div>
        {reviews}
      </div>
    )
  }
}

export default MemesShowContainer;
