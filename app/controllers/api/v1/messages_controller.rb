class Api::V1::MessagesController < Api::V1::BaseController
  doorkeeper_for :all

  respond_to :json

  def index
    headers['Access-Control-Allow-Origin'] = "*"
    respond_with current_user.messages
  end

  def create
    headers['Access-Control-Allow-Origin'] = "*"
    respond_with current_user.messages.create(params[:message])
  end
end
