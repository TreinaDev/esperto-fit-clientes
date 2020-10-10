Rails.application.routes.draw do
  devise_for :personals
  devise_for :clients
  root to: 'home#index'

  resources :subsidiaries, only: :show do
    post 'enrolls/confirm', to: 'enrolls#confirm'
    resources :enrolls, only: :new
    get 'search', on: :collection
  end

  resources :enrolls, only: :create
  resources :profiles, only: [:index, :show, :new,:create, :edit, :update]
end
