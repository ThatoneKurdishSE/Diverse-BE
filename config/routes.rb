Rails.application.routes.draw do
  resources :user_communities
  resources :communities
  resources :users

  # Custom Routes
  post '/login', to: 'users#login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
