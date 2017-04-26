import React from 'react';

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      
    };
  }

  componentDidMount() {
    fetch(`/memes/${this.props.memeId}/reviews/${this.props.reviewId}/api/review_votes.json`)
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
        this.setState({ review_votes: body });
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

  render() {
    debugger;
    return (
      <h1>Your Review:</h1>
    );
  }
}

export default App;
