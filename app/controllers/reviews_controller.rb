class ReviewsController < ApplicationController
  def create
    @meme = Meme.find(params[:meme_id])
    @review = Review.new(review_params)
    @review.meme = @meme
    @review.user = current_user

    if @review.save
      flash[:success] = 'Review added successfully'
      redirect_to meme_path(@meme)
    else
      flash[:errors] = @review.errors.full_messages.join(', ')
      redirect_to meme_path(@meme)
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :votes, :body)
  end
end
