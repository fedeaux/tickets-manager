Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  get 'templates/*name' => "templates#template"
  root 'dashboard#index'

  namespace :api, defaults: { format: :json } do
    resources :tickets, only: [:index, :create, :show] do
      resources :ticket_messages, path: :messages, only: [:index, :create]
    end

    namespace :admin do
      resources :tickets, only: [:index, :show, :update]
      resources :users, only: [:index, :update]
    end
  end

  get 'api/admin/reports/tickets' => 'api/admin/reports#tickets'
end
