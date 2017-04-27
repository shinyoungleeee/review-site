class ReviewsController < ApplicationController
  def create
    meme = Meme.find(params[:meme_id])
    review = Review.new(review_params)
    review.meme = meme
    review.user = current_user

    if review.save
      flash[:success] = 'Review added successfully'
      ReviewMailer.new_review(review).deliver_later
      redirect_to meme_path(meme)
    else
      flash[:errors] = review.errors.full_messages.join(', ')
      redirect_to meme_path(meme)
    end
  end

  def edit
    @meme = Meme.find(params[:meme_id])
    @review = Review.find(params[:id])
  end

  def update
    @meme = Meme.find(params[:meme_id])
    @review = Review.find(params[:id])
    @new_review= @review.update_attributes(review_params)
    if @review.save
      flash[:success] = 'Review updated successfully'
      redirect_to meme_path(@meme)
    else
      flash[:errors] = @review.errors.full_messages.join(', ')
      render :edit
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :votes, :body)
  end
end
