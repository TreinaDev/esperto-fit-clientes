Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :personals
  devise_for :clients

  resources :appointments, only: [:index, :show, :new, :create, :edit, :update]

  resources :subsidiaries, only: [] do
    get 'search', on: :collection
  end
end
