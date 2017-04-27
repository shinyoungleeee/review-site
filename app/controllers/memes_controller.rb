class MemesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :authorize_user, only: [:new, :create]

  def index
    if params[:search]
      @memes = Meme.search(params[:search])
    else
      @memes = Meme.all
    end
  end

  def new
    if current_user.nil?
      flash[:errors] = "Please sign in first."
      redirect_to memes_path
    end
    @meme = Meme.new
  end

  def create
    if current_user.nil?
      flash[:errors] = "Please sign in first."
      redirect_to memes_path
    else
      @meme = Meme.new(meme_params)
      @meme.contributor = current_user
      if @meme.save
        flash[:success] = 'Meme added successfully'
        redirect_to meme_path(@meme)
      else
        flash[:errors] = @meme.errors.full_messages.join(', ')
        render :new
      end
    end
  end

  def show
    @meme = Meme.find(params[:id])
    @review = Review.new
    @reviews = @meme.reviews
    @current_user_review = false
    if !@reviews.find_by_user_id(current_user).nil?
      @current_user_review = true
    end
    @current_user_id = 0
    if !current_user.nil?
      @current_user_id = current_user.id
    end
  end

  def destroy
    @meme = Meme.find(params[:id])
    @meme.destroy
    flash[:success] = "Meme deleted successfully"
    redirect_to memes_path
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

  private

  def meme_params
    params.require(:meme).permit(:name, :image_url, :description)
  end

  def authorize_user
    if !current_user.admin?
      raise ActionController::RoutingError.new("Need Admin Credentials to add meme")
    end
  end

end
