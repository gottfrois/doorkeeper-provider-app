class Api::V1::MessagesController < ApplicationController
  before_filter :authenticate_user!

  respond_to :json

  def index
    respond_with Message.all
  end
end
