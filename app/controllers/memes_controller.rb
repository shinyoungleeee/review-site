class MemesController < ApplicationController
  before_action :authenticate_user!, only: [:secret]

  def index
    @memes = Meme.all
  end

  def secret
  end
end
