class Api::V1::MessagesController < Api::V1::BaseController
  doorkeeper_for :all

  respond_to :json

  def index
    respond_with current_user.messages
  end

  def create
    respond_with current_user.messages.create(params[:message])
  end
end
