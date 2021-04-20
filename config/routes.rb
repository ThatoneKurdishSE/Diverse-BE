Rails.application.routes.draw do
  resources :user_communities
  resources :communities
  resources :users
  post "users", to: "users#create"
  post "login", to: "users#login"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
