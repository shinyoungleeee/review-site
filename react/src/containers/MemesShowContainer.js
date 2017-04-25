import React from 'react';
import { Link } from 'react-router';
import ReviewTile from '../components/ReviewTile'

class MemesShowContainer extends React.Component {
  constructor(props){
    super(props)
    this.state = {
      reviews: [],
      userUpvote: false,
      userDownvote: false
    };

    this.handleUpvoteClick = this.handleUpvoteClick.bind(this)
    this.handleDownvoteClick = this.handleDownvoteClick.bind(this)
    this.createReviewVote = this.createReviewVote.bind(this)
    this.updateReviewVote = this.updateReviewVote.bind(this)
    this.didUserVote = this.didUserVote.bind(this)
  }

  componentDidMount() {
    fetch(`/memes/${this.props.params.memeId}/api/reviews.json`)
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

  didUserVote(reviewVotes) {
    let userId = document.getElementById('app').dataset.userId
    let found = false;
    for(let i = 0; i < reviewVotes.length; i++) {
      if (reviewVotes[i].user_id == userId) {
        found = true;
        this.setState({
          userUpvote: reviewVotes[i].upvote,
          userDownvote: reviewVotes[i].downvote
        })
        break;
      }
    }
    return found
  }

  handleUpvoteClick(event, review_id, reviewVotes) {
    if (this.didUserVote(reviewVotes)) {
      if (this.state.userDownvote) {
        this.updateReviewVote(review_id, false, false)
        this.setState({
          userUpvote: false,
          userDownvote: false
        })
      } else if (!this.state.userDownvote) {
        this.updateReviewVote(review_id, true, false)
        this.setState({
          userUpvote: true,
          userDownvote: false
        })
      }
    } else {
      this.createReviewVote(review_id, true, false)
      this.setState({
        userUpvote: true,
        userDownvote: false
      })
    }
  }

  handleDownvoteClick(event, review_id, reviewVotes) {
    if (this.didUserVote(reviewVotes)) {
      if (this.state.userUpvote) {
        this.updateReviewVote(review_id, false, false)
        this.setState({
          userUpvote: false,
          userDownvote: false
        })
      } else if (!this.state.userUpvote) {
        this.updateReviewVote(review_id, false, true)
        this.setState({
          userUpvote: false,
          userDownvote: true
        })
      }
    } else {
      this.createReviewVote(review_id, false, true)
      this.setState({
        userUpvote: false,
        userDownvote: true
      })
    }
  }

  createReviewVote(review_id, upvote, downvote) {
    let votePayload = {
      review_vote: {
        review_id: review_id,
        upvote: upvote,
        downvote: downvote,
        user_id: document.getElementById('app').dataset.userId
      }
    }
    fetch(`/memes/${this.props.params.memeId}/api/reviews.json`, {
      method: 'POST',
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

  updateReviewVote(review_id, upvote, downvote) {
    let votePayload = {
      review_vote: {
        review_id: review_id,
        upvote: upvote,
        downvote: downvote,
        user_id: document.getElementById('app').dataset.userId
      }
    }
    fetch(`/memes/${this.props.params.memeId}/api/reviews.json`, {
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

  render() {
    let reviews = this.state.reviews.map(review => {
      let upvoteHandler = () => {
        this.handleUpvoteClick(event, review.id, review.review_votes)
      }
      let downvoteHandler = () => {
        this.handleDownvoteClick(event, review.id, review.review_votes)
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
