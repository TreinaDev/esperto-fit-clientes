Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :personals
  devise_for :clients

  resources :appointments, only: %i[index show new create edit update] do
    resources :order_appointments, only: [:create]
    member do
      put 'appointments/:id', to: 'appointments#cancel', as: :cancel
    end
  end

  resources :order_appointments, only: [:index, :show]

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

  namespace :api do
    namespace :v1 do
      resources :clients, only: %i[index show]
      post 'users/:cpf/ban', to: 'users#ban', as: 'user_ban'
    end
  end

  resources :enrolls, only: :create
  resources :profiles, only: [:index, :show, :new,:create, :edit, :update]
end
