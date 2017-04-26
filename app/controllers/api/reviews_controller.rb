class Api::ReviewsController < ApiController
  protect_from_forgery unless: -> { request.format.json? }

  def show
    reviews = Meme.find(params[:meme_id]).reviews
    reviews.each do |review|
      review.belongs_to_user?(current_user)
    end
    render json: reviews, include: [user: { only: [:username] }], methods: [:vote_count, :current_user]
  end

  def update
    if current_user.nil?
      flash[:notice] = "Please sign in first."
    else
      this_review = Review.find(review_vote_params["review_id"])
      review_votes = this_review.review_votes
      if this_review.did_user_vote?(current_user)
        vote = review_votes.find { |vote| vote.user == current_user }
        if review_vote_params[:upvote] && !vote.upvote && !vote.downvote
          ReviewVote.update(vote, upvote: true)
        elsif review_vote_params[:upvote] && !vote.upvote && vote.downvote
          ReviewVote.update(vote, downvote: false)
        elsif !review_vote_params[:upvote] && !vote.upvote && !vote.downvote
          ReviewVote.update(vote, downvote: true)
        elsif !review_vote_params[:upvote] && vote.upvote && !vote.downvote
          ReviewVote.update(vote, upvote: false)
        end
      else
        if review_vote_params[:upvote]
          ReviewVote.create(review: this_review, upvote: true, user: current_user)
        else
          ReviewVote.create(review: this_review, downvote: true, user: current_user)
        end
      end
    end
    reviews = Meme.find(params[:meme_id]).reviews
    reviews.each do |review|
      review.belongs_to_user?(current_user)
    end
    render json: reviews, include: [user: { only: [:username] }], methods: [:vote_count, :current_user]
  end

  def destroy
    if current_user.nil?
      flash[:notice] = "Please sign in first."
    else
      meme = Meme.find(params[:meme_id])
      this_review = Review.find(delete_review_params[:review_id])
      this_review.review_votes.destroy_all
      this_review.destroy
      reviews = meme.reviews
      reviews.each do |review|
        review.belongs_to_user?(current_user)
      end
      render json: reviews, include: [user: { only: [:username] }], methods: [:vote_count, :current_user]
    end
  end

  private

  def review_vote_params
    params.require(:review_vote).permit(:review_id, :upvote)
  end

  def delete_review_params
    params.require(:delete_review).permit(:review_id)
  end
end
