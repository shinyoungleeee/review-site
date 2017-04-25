class Api::ReviewsController < ApiController
  def show
    respond_to do |format|
      format.json do
        reviews = Meme.find(params[:meme_id]).reviews
        # reviews.each do |review|
        #   review.did_user_vote?(current_user)
        # end
        render json: reviews.to_json(include: [:review_votes], methods: [:vote_count])
      end
    end
  end

  def create
    respond_to do |format|
      format.json do
        ReviewVote.create(review_vote_params)
        reviews = Meme.find(params[:meme_id]).reviews
        render json: reviews.to_json(include: [:review_votes], methods: [:vote_count])
      end
    end
  end

  def update
    respond_to do |format|
      format.json do
        votes = Review.find(review_vote_params["review_id"]).review_votes
        vote = votes.find_by_user_id(review_vote_params["user_id"])
        ReviewVote.update(vote, review_vote_params)
        reviews = Meme.find(params[:meme_id]).reviews
        render json: reviews.to_json(include: [:review_votes], methods: [:vote_count])
      end
    end
  end

  private

  def review_vote_params
    params.require(:review_vote).permit(:review_id, :upvote, :downvote, :user_id)
  end
end
