Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :personals
  devise_for :clients

  resources :appointments, only: [:index, :show, :new, :create, :edit, :update] do
    resources :order_appointments, only: [:create]
  end

  resources :order_appointments, only: [:index]

  resources :clients, only: [] do
    resources :ordered_appointments, only: :index, module: :clients
  end

  resources :subsidiaries, only: :show do
    post 'enrolls/confirm', to: 'enrolls#confirm'
    resources :enrolls, only: :new
    get 'search', on: :collection
    resources :personals, only: [] do
      post 'add', on: :member
    end
  end

  resources :enrolls, only: :create
end
