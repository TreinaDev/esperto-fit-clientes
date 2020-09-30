Rails.application.routes.draw do
  devise_for :personals
  devise_for :clients, controllers: {registrations: 'registrations'}

  root to: 'home#index'
end
