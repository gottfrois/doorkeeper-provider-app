class Api::V1::MessagesController < Api::V1::BaseController
  doorkeeper_for :all

  respond_to :json

  def show
    render :partial => 'messages/show.json'
  end
end
