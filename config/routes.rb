require 'api_constraints'

Api::Application.routes.draw do
  use_doorkeeper

  devise_for :users

  root to: 'home#index'

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      match 'conversations', to: 'conversations#index'
      match 'users/me', to: 'users#me'
    end
  end
end
