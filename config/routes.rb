Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # Custom endpoints for the app
  post '/access', to: 'access_control#signin'
  get '/access', to: 'access_control#logout'

  # Custom root page for the application
  root 'users#index'
end
