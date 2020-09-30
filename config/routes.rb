Rails.application.routes.draw do
  devise_for :personals
  devise_for :clients

  root to: 'home#index'

  resources :subsidiaries, only: :show
end
