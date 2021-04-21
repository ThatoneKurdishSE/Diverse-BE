Rails.application.routes.draw do
  resources :community_owners
  resources :comments
  resources :posts
  resources :user_communities
  resources :communities
  resources :users

  # Custom Routes
  post "/users", to: "users#create"
  post "/login", to: "users#login"
  get "/profile", to: 'users#profile'
  get "/community_search", to: 'communities#search'
  get "/user_search", to: 'users#search'
  get "/community_members", to: 'communities#community_members'
  get "/user_communities", to: 'users#user_communities'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
