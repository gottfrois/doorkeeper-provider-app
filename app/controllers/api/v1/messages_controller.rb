class Api::V1::MessagesController < Api::V1::BaseController
  before_filter :_conversation

  doorkeeper_for :all

  respond_to :json

  def index
    respond_with @messages = @conversation.messages
  end

  def show
    respond_with @message = @conversation.messages.find(params[:id])
  end

private

  def _conversation
    @conversation ||= current_user.conversations.find(params[:conversation_id])
  end
end
