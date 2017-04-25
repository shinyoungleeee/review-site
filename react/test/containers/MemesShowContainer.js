import MemesShowContainer from 'containers/MemesShowContainer'
import ReviewTile from 'components/ReviewTile'

describe('MemesShowContainer', () => {
  let params, wrapper;

  beforeEach(() => {
    params = { memeId: "3" }
    spyOn(MemesShowContainer.prototype, 'updateReviewVote').and.callThrough();
    wrapper = mount(
      <MemesShowContainer
        params={params}
      />
    )
  })

  it('should have the specifed initial state', () => {
    expect(wrapper.state()).toEqual({ reviews: [] });
  });

  it('should render a ReviewTile Component when this.state.reviews has a review', () => {
    wrapper.setState({ reviews: [{id: 1, rating: 10, body: 'This is the body.', vote_count: 2 }] })
    expect(wrapper.find(ReviewTile)).toBePresent();
  });

  it('should render a ReviewTile Component with props of upvote and downvote functions', () => {
    wrapper.setState({ reviews: [{id: 1, rating: 10, body: 'This is the body.', vote_count: 2 }] })
    expect(wrapper.find(ReviewTile).props()).toEqual({
      id: 1,
      rating: 10,
      body: 'This is the body.',
      voteCount: 2,
      upvoteHandler: jasmine.any(Function),
      downvoteHandler: jasmine.any(Function)
    });
  });

  it('should render the tree of the ReviewTile component', () => {
    wrapper.setState({ reviews: [{id: 1, rating: 10, body: 'This is the body.', vote_count: 2 }] })
    let pageText = wrapper.text();

    expect(pageText).toMatch('Rating: 10');
    expect(pageText).toMatch('This is the body.');
  });

  it('should invoke updateReviewVote when the upvoteHandler function of the child ReviewTile is called', () => {
    wrapper.setState({ reviews: [{id: 1, rating: 10, body: 'This is the body.', vote_count: 2 }] })
    wrapper.find(ReviewTile).props().upvoteHandler();
    expect(MemesShowContainer.prototype.updateReviewVote).toHaveBeenCalled();
  })

  it('should invoke updateReviewVote when the downvoteHandler function of the child ReviewTile is called', () => {
    wrapper.setState({ reviews: [{id: 1, rating: 10, body: 'This is the body.', vote_count: 2 }] })
    wrapper.find(ReviewTile).props().downvoteHandler();
    expect(MemesShowContainer.prototype.updateReviewVote).toHaveBeenCalled();
  })
});
