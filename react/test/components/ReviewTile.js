import ReviewTile from 'components/ReviewTile'

describe('ReviewTile', () => {
  let key, id, rating, body, voteCount, upvoteHandler, downvoteHandler, deleteHandler, wrapper;

  beforeEach(() => {
    upvoteHandler = jasmine.createSpy('upvoteHandler spy')
    downvoteHandler = jasmine.createSpy('downvoteHandler spy')
    deleteHandler = jasmine.createSpy('deleteHandler spy')
    wrapper = mount(
      <ReviewTile
        key={1}
        id={1}
        rating={10}
        author={"user"}
        body={'This is the body.'}
        voteCount={2}
        upvoteHandler={upvoteHandler}
        downvoteHandler={downvoteHandler}
        memeId={1}
        deleteHandler={deleteHandler}
        belongsToCurrentUser={true}
        admin={false}
      />
    )
  })

  it('should render a div with the rating props value', () => {
    expect(wrapper.find('.small-1.columns.text-center.rating').find('strong').at(0).text()).toBe('10');
    expect(wrapper.find('.small-1.columns.text-center.rating').find('strong').at(1).text()).toBe('RATING');
  });

  it('should render a div with the username and body props value', () => {
    expect(wrapper.find('.small-7.columns').find('p').text()).toBe('user: This is the body.');
  });

  it('should render a h6 tag with the voteCount props value', () => {
    expect(wrapper.find('h6').text()).toBe('2');
  });

  it('should render a button tag with a thumbs up value', () => {
    expect(wrapper.find('button').at(0).text()).toBe('👍');
  });

  it('should render a button tag with a thumbs down value', () => {
    expect(wrapper.find('button').at(1).text()).toBe('👎');
  });

  it('should render a button tag with the value Edit Review if currentUser props is true', () => {
    expect(wrapper.find('a').find('.button').text()).toBe('Edit Review');
  });

  it('should render a button tag with the value Edit Review if admin props is true', () => {
    wrapper = mount(
      <ReviewTile
        key={1}
        id={1}
        rating={10}
        body={'This is the body.'}
        voteCount={2}
        upvoteHandler={upvoteHandler}
        downvoteHandler={downvoteHandler}
        memeId={1}
        deleteHandler={deleteHandler}
        belongsToCurrentUser={false}
        admin={true}
      />
    )
    expect(wrapper.find('a').find('.button').text()).toBe('Edit Review');
  });

  it('should render a button tag with the value Delete Review if currentUser props is true', () => {
    expect(wrapper.find('button').at(2).text()).toBe('Delete Review');
  });

  it('should render a button tag with the value Delete Review if admin props is true', () => {
    wrapper = mount(
      <ReviewTile
        key={1}
        id={1}
        rating={10}
        body={'This is the body.'}
        voteCount={2}
        upvoteHandler={upvoteHandler}
        downvoteHandler={downvoteHandler}
        memeId={1}
        deleteHandler={deleteHandler}
        belongsToCurrentUser={false}
        admin={true}
      />
    )
    expect(wrapper.find('button').at(2).text()).toBe('Delete Review');
  });

  it('should NOT render a button tag with the value Edit Review if currentUser and admin props are false', () => {
    wrapper = mount(
      <ReviewTile
        key={1}
        id={1}
        rating={10}
        body={'This is the body.'}
        voteCount={2}
        upvoteHandler={upvoteHandler}
        downvoteHandler={downvoteHandler}
        memeId={1}
        deleteHandler={deleteHandler}
        belongsToCurrentUser={false}
        admin={false}
      />
    )
    expect(wrapper.text()).not.toContain('Edit Review');
  });

  it('should NOT render a button tag with the value Delete Review if currentUser and admin props are false', () => {
    wrapper = mount(
      <ReviewTile
        key={1}
        id={1}
        rating={10}
        body={'This is the body.'}
        voteCount={2}
        upvoteHandler={upvoteHandler}
        downvoteHandler={downvoteHandler}
        memeId={1}
        deleteHandler={deleteHandler}
        belongsToCurrentUser={false}
        admin={false}
      />
    )
    expect(wrapper.text()).not.toContain('Delete Review');
  });

  it('should invoke the upvoteHandler function from props when clicked', () => {
    wrapper.find('button').at(0).simulate('click');
    expect(upvoteHandler).toHaveBeenCalled();
  })

  it('should invoke the downvoteHandler function from props when clicked', () => {
    wrapper.find('button').at(1).simulate('click');
    expect(downvoteHandler).toHaveBeenCalled();
  })

  it('should invoke the deleteHandler function from props when clicked', () => {
    wrapper.find('button').at(2).simulate('click');
    expect(deleteHandler).toHaveBeenCalled();
  })
});
