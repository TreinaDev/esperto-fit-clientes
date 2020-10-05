Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :personals
  devise_for :clients
  

  resources :personals, only: [] do
    resources :appointments, only: [:index] 
  end

  resources :subsidiaries, only: [] do
    get 'search', on: :collection
  end
end
