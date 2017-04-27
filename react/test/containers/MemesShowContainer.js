import MemesShowContainer from 'containers/MemesShowContainer'
import ReviewTile from 'components/ReviewTile'

describe('MemesShowContainer', () => {
  let params, wrapper;

  beforeEach(() => {
    params = { memeId: "3" }
    spyOn(MemesShowContainer.prototype, 'updateReviewVote').and.callThrough();
    spyOn(MemesShowContainer.prototype, 'deleteReview').and.callThrough();
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
    wrapper.setState({ reviews: [{id: 1, rating: 10, body: 'This is the body.', vote_count: 2, belongs_to_tested_user: true, user: { username: 'user'} }] })
    expect(wrapper.find(ReviewTile)).toBePresent();
  });

  it('should render a ReviewTile Component with props of upvote and downvote functions', () => {
    wrapper.setState({ reviews: [{id: 1, rating: 10, body: 'This is the body.', vote_count: 2, belongs_to_tested_user: true, user: { username: 'user'} }] })
    expect(wrapper.find(ReviewTile).props()).toEqual({
      id: 1,
      rating: 10,
      author: 'user',
      body: 'This is the body.',
      voteCount: 2,
      upvoteHandler: jasmine.any(Function),
      downvoteHandler: jasmine.any(Function),
      memeId: "3",
      deleteHandler: jasmine.any(Function),
      belongsToCurrentUser: true
    });
  });

  it('should render the tree of the ReviewTile component', () => {
    wrapper.setState({ reviews: [{id: 1, rating: 10, body: 'This is the body.', vote_count: 2, belongs_to_tested_user: true, user: { username: 'user'} }] })
    let pageText = wrapper.text();

    expect(pageText).toMatch('10');
    expect(pageText).toMatch('This is the body.');
  });

  it('should invoke updateReviewVote when the upvoteHandler function of the child ReviewTile is called', () => {
    wrapper.setState({ reviews: [{id: 1, rating: 10, body: 'This is the body.', vote_count: 2, belongs_to_tested_user: true, user: { username: 'user'} }] })
    wrapper.find(ReviewTile).props().upvoteHandler();
    expect(MemesShowContainer.prototype.updateReviewVote).toHaveBeenCalled();
  })

  it('should invoke updateReviewVote when the downvoteHandler function of the child ReviewTile is called', () => {
    wrapper.setState({ reviews: [{id: 1, rating: 10, body: 'This is the body.', vote_count: 2, belongs_to_tested_user: true, user: { username: 'user'} }] })
    wrapper.find(ReviewTile).props().downvoteHandler();
    expect(MemesShowContainer.prototype.updateReviewVote).toHaveBeenCalled();
  })

  it('should invoke deleteReview when the deleteHandler function of the child ReviewTile is called', () => {
    wrapper.setState({ reviews: [{id: 1, rating: 10, body: 'This is the body.', vote_count: 2, belongs_to_tested_user: true, user: { username: 'user'} }] })
    wrapper.find(ReviewTile).props().deleteHandler();
    expect(MemesShowContainer.prototype.deleteReview).toHaveBeenCalled();
  })
});
