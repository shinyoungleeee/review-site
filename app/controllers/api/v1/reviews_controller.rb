class Api::V1::ReviewsController < ApiController
  protect_from_forgery unless: -> { request.format.json? }

  def index
    reviews = Meme.find(params[:meme_id]).reviews
    reviews.each do |r|
      r.check_belongs_to_user(current_user)
    end
    if current_user.nil?
      render json: {
        reviews: JSON.parse(reviews.to_json(include: [user: { only: [:username] }], methods: [:vote_count, :belongs_to_tested_user])),
        current_user: { admin: false }
      }
    else
      render json: {
        reviews: JSON.parse(reviews.to_json(include: [user: { only: [:username] }], methods: [:vote_count, :belongs_to_tested_user])),
        current_user: JSON.parse(current_user.to_json(only: [:admin]))
      }
    end
  end

  def update
    if !current_user.nil? && (review_vote_params[:upvote] == true || review_vote_params[:upvote] == false)
      review = Review.find(params[:id])
      review_votes = review.review_votes
      if review.did_user_vote?(current_user)
        vote = review_votes.find { |v| v.user == current_user }
        if review_vote_params[:upvote] && !vote.upvote && !vote.downvote
          ReviewVote.update(vote, upvote: true)
        elsif review_vote_params[:upvote] && !vote.upvote && vote.downvote
          ReviewVote.update(vote, downvote: false)
        elsif !review_vote_params[:upvote] && !vote.upvote && !vote.downvote
          ReviewVote.update(vote, downvote: true)
        elsif !review_vote_params[:upvote] && vote.upvote && !vote.downvote
          ReviewVote.update(vote, upvote: false)
        end
      elsif review_vote_params[:upvote]
        ReviewVote.create(review: review, upvote: true, user: current_user)
      elsif !review_vote_params[:upvote]
        ReviewVote.create(review: review, downvote: true, user: current_user)
      end
    end
    reviews = Meme.find(params[:meme_id]).reviews
    reviews.each do |r|
      r.check_belongs_to_user(current_user)
    end
    if current_user.nil?
      render json: {
        reviews: JSON.parse(reviews.to_json(include: [user: { only: [:username] }], methods: [:vote_count, :belongs_to_tested_user])),
        current_user: { admin: false }
      }
    else
      render json: {
        reviews: JSON.parse(reviews.to_json(include: [user: { only: [:username] }], methods: [:vote_count, :belongs_to_tested_user])),
        current_user: JSON.parse(current_user.to_json(only: [:admin]))
      }
    end
  end

  def destroy
    if !current_user.nil?
      Meme.find(params[:meme_id])
      review = Review.find(params[:id])
      review.review_votes.destroy_all
      review.destroy
    end
    reviews = Meme.find(params[:meme_id]).reviews
    reviews.each do |r|
      r.check_belongs_to_user(current_user)
    end
    if current_user.nil?
      render json: {
        reviews: JSON.parse(reviews.to_json(include: [user: { only: [:username] }], methods: [:vote_count, :belongs_to_tested_user])),
        current_user: { admin: false }
      }
    else
      render json: {
        reviews: JSON.parse(reviews.to_json(include: [user: { only: [:username] }], methods: [:vote_count, :belongs_to_tested_user])),
        current_user: JSON.parse(current_user.to_json(only: [:admin]))
      }
    end
  end

  private

  def review_vote_params
    params.require(:review_vote).permit(:upvote)
  end
end
