class Api::V1::UsersController < Api::V1::BaseController
  doorkeeper_for :all

  respond_to :json

  def me
    respond_with current_user
  end

  def index
    respond_with @users = User.all
  end
end
