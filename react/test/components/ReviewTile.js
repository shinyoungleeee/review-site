import ReviewTile from 'components/ReviewTile'

describe('ReviewTile', () => {
  let key, id, rating, body, voteCount, upvoteHandler, downvoteHandler, wrapper;

  beforeEach(() => {
    upvoteHandler = jasmine.createSpy('upvoteHandler spy')
    downvoteHandler = jasmine.createSpy('downvoteHandler spy')
    wrapper = mount(
      <ReviewTile
        key={1}
        id={1}
        rating={10}
        body={'This is the body.'}
        voteCount={2}
        upvoteHandler={upvoteHandler}
        downvoteHandler={downvoteHandler}
      />
    )
  })

  it('should render a strong p tag with the rating props value', () => {
    expect(wrapper.find('strong').text()).toBe('Rating: 10');
  });

  it('should render a regular p tag with the body props value', () => {
    expect(wrapper.find('p').at(1).text()).toBe('This is the body.');
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

  it('should invoke the upvoteHandler function from props when clicked', () => {
    wrapper.find('button').at(0).simulate('click');
    expect(upvoteHandler).toHaveBeenCalled();
  })

  it('should invoke the downvoteHandler function from props when clicked', () => {
    wrapper.find('button').at(1).simulate('click');
    expect(downvoteHandler).toHaveBeenCalled();
  })
});
