class MemesController < ApplicationController
  before_action :authenticate_user!, only: [:secret]

  def index
    @memes = Meme.all
  end

  def new
    @meme = Meme.new
  end

  def create
    @meme = Meme.new(meme_params)
    if @meme.save
      flash[:success] = 'Meme added successfully'
      redirect_to meme_path(@meme)
    else
      flash[:errors] = @meme.errors.full_messages.join(', ')
      render :new
    end
  end

  def show
    @meme = Meme.find(params[:id])
    @review = Review.new
    @reviews = @meme.reviews
    @review.meme = @meme
  
  end

  def edit
    @meme = Meme.find(params[:id])
  end

  def update
    @meme = Meme.find(params[:id])
    @new_meme = @meme.update_attributes(meme_params)
    if @meme.save
      flash[:success] = 'Meme updated successfully'
      redirect_to meme_path(@meme)
    else
      flash[:errors] = @meme.errors.full_messages.join(', ')
      render :edit
    end
  end

  def secret
  end

  private

  def meme_params
    params.require(:meme).permit(:name, :image_url, :description)
  end

  # def review_params
  #   params.require(:review).permit(:rating, :votes, :body)
  # end

end
