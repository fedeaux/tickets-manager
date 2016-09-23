Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  get 'templates/*name' => "templates#template"
  root 'dashboard#index'
  namespace :api, defaults: { format: :json } do
    resources :tickets, only: [:index, :create, :show]
  end
end
