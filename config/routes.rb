Rails.application.routes.draw do
  devise_for :personals
  devise_for :clients
  root to: 'home#index'

  resources :subsidiaries, only: [:show] do
    get 'search', on: :collection
    resources :personals, only: [] do
      post 'add', on: :member
    end
  end
end
