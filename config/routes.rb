Rails.application.routes.draw do
  devise_for :personals
  devise_for :clients

  root to: 'home#index'

  resources :subsidiaries, only: :show do
    resources :enrolls, only: %i[new create]
  end
end
