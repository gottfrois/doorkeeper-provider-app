class Api::V1::BaseController < ApplicationController
  after_filter :set_access_control_origin_headers

private

  def set_access_control_origin_headers
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    response.headers['Access-Control-Max-Age'] = "1728000"
  end

  def current_user
    if doorkeeper_token
      @current_user ||= User.find(doorkeeper_token.resource_owner_id)
    end
  end
end
