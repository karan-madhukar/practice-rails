Rails.application.routes.draw do
  root "articles#index"
  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"
  get "error", to: "sessions#error"
  resources :users, except: [:new, :index]

  resources :articles do
    member do
      patch "like_reaction"
      patch "dislike_reaction"

    end
  end

  resources :reactions
end
