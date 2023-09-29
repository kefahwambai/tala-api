Rails.application.routes.draw do
  resources :feedbacks
  resources :password_resets, only: [:create, :edit, :update]
  resources :loans
  resources :clients
  resources :users
  resource  :session, only: [:show, :create, :destroy]

  
  post '/signup', to: 'users#create'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/me', to: 'users#show' 
  get '/api/session', to: 'sessions#show'
end
