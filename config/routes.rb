Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  get 'templates/*name' => "templates#template"
  root 'dashboard#index'
end
