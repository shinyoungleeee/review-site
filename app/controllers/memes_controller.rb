class MemesController < ApplicationController
  before_action :authenticate_user!, only: [:secret]

  def index
    @memes = Meme.all
  end

  def show
    @meme = Meme.find(params[:id])
  end

  def secret
  end
end
