class Api::V1::UsersController < Api::V1::BaseController
  before_filter :titi
  after_filter :toto
  doorkeeper_for :all

  respond_to :json

  def titi
    logger.debug params.inspect
  end

  def show
    logger.debug params.inspect
    respond_with current_user.as_json(except: :password_digest)
  end

  def toto
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    response.headers['Access-Control-Max-Age'] = "1728000"    
  end
end
