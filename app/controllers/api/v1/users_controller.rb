class Api::V1::UsersController < Api::V1::BaseController
  doorkeeper_for :all

  respond_to :json

  def show
    respond_with current_user.as_json(except: :password_digest)
  end
end
