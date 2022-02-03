Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }

  resources :users do
  end  
  
  resources :gems do

  end  
  
  root "pages#index"
end
