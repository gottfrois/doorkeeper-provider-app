class Api::V1::ConversationsController < Api::V1::BaseController
  doorkeeper_for :all

  respond_to :json

  def index
    render :partial => 'conversations/index.json'
  end
end
