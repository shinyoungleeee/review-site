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
  end

  def destroy
    @meme = Meme.find(params[:id])
    @meme.destroy
    flash[:success] = "Meme deleted successfully"
    redirect_to memes_path
  end

  def secret
  end

  private

  def meme_params
    params.require(:meme).permit(:name, :image_url, :description)
  end
end
