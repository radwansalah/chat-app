require 'api_constraints.rb'

Rails.application.routes.draw do
  # Api definition
  namespace :api, defaults: { format: :json }  do
    namespace :v1, constraints: ApiConstraints.new(version: 1, default: true) do

      resources :applications, only: [:index, :create, :update, :show] do
        resources :chats, only: [:index, :show, :update]
      end

      resources :chats, only: [] do
        resources :messages, only: [:index, :update]
      end

      resources :chats, only: [:create]
      resources :messages, only: [:create]

    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
