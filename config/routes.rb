Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :personals
  devise_for :clients

  resources :appointments, only: [:index, :show, :new, :create, :edit, :update]

  resources :subsidiaries, only: :show do
    post 'enrolls/confirm', to: 'enrolls#confirm'
    resources :enrolls, only: :new
    get 'search', on: :collection
  end

  resources :enrolls, only: :create
end
