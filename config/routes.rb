Rails.application.routes.draw do
  devise_for :personals
  devise_for :clients
  root to: 'home#index'

  resources :subsidiaries, only: [] do
    get 'search', on: :collection
  end

  namespace :api do
    namespace :v1 do
      resources :clients, only: %i[index show]
    end
  end
end
