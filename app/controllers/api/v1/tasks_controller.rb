class Api::V1::TasksController < Api::V1::BaseController
  doorkeeper_for :all

  respond_to :json

  def index
    render :partial => 'tasks/index.json'
  end
end
