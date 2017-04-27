class AdminsController < ApplicationController
    before_action :authorize_user, only: [:index, :destroy]

  def index
    @users= User.all
  end

  def destroy


   User.find(params[:id]).destroy


   redirect_to admins_path
 end

  def authorize_user
    if !current_user.admin?
      raise ActionController::RoutingError.new("Need Admin Credentials to delete user")
    end
  end
end
