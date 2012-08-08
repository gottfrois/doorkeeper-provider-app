class Api::V1::ConversationsController < Api::V1::BaseController
  doorkeeper_for :all

  respond_to :json

  def index
    respond_with @conversations = current_user.conversations
  end

  def show
    respond_with @conversation = current_user.conversations.find(params[:id])
  end

  def create
    @conversation = current_user.conversations.create!(params[:conversation])
    respond_with @conversation, location: nil
  end
end
