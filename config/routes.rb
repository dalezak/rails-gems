Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }

  resources :users
  
  resources :gems
  
  root "pages#index"
end
