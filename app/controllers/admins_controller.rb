class AdminsController < ApplicationController
  before_action :authorize_user

  def index
    @users = User.all
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to admins_path
  end

  def make_admin
    User.find(params[:admin_id]).update(admin: true)
    redirect_to admins_path
  end

  def remove_admin
    User.find(params[:admin_id]).update(admin: false)
    redirect_to admins_path
  end

  private

  def authorize_user
    if !current_user.admin?
      raise ActionController::RoutingError.new("Need Admin Credentials to delete user")
    end
  end
end
