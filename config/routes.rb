Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  use_doorkeeper

  mount ActionCable.server => '/cable'

  # Route de santé de l'application
  get "up" => "rails/health#show", as: :rails_health_check

  # Ajouter les méthodes GET et POST pour le webhook
  match '/webhook/messenger', to: 'webhooks#messenger', via: [:get, :post]

  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: {
        registrations: 'api/v1/registrations'
      }

      resources :conversations, only: [:index, :show, :create, :update, :destroy] do
        resources :messages, only: [:index, :create]
      end
    end
  end
end
