Rails.application.routes.draw do
  resources :user_communities
  resources :communities
  resources :users

  # Custom Routes
  post "/users", to: "users#create"
  post "/login", to: "users#login"
  get "/profile", to: 'users#profile'
  get "/community_search", to: 'communities#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
