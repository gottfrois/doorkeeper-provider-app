require 'api_constraints'

Api::Application.routes.draw do
  devise_for :users

  root :to => 'home#index'

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :tokens, :only => [:create, :destroy]
      resources :messages, :only => :index
    end
  end
end
