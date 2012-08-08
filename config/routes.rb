require 'api_constraints'

Api::Application.routes.draw do
  use_doorkeeper

  devise_for :users

  root to: 'home#index'

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do

      resources :conversations, only: [:index, :show, :create] do
        resources :messages, only: [:index, :show, :update, :destroy]
      end

      resources :users, only: [:index, :me, :create] do
        get 'me', on: :collection
      end
    end
  end
end
