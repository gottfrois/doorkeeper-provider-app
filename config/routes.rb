require 'api_constraints'

Api::Application.routes.draw do
  use_doorkeeper

  devise_for :users

  root to: 'home#index'

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do

      resources :conversations, only: [:index, :show] do
        resources :messages, only: [:index, :show]
      end

      resources :users, only: [:index, :me] do
        get 'me', on: :collection
      end
    end
  end
end
