Rails.application.routes.draw do
  root "articles#index"
  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"
  get "error", to: "sessions#error"
  resources :users, except: [:new, :index]

  resources :reactions do
    member do
      patch "like_update"
      patch "dislike_update"
    end
  end

  resources :articles
  get "download_pdf", to: "articles#pdf_download"
  resources :categories
  resources :comments
end
