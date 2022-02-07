Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }

  resources :users, path: :devs do
    resources :gems, only: [:index]
  end  
  
  resources :gems do
    member do
      post "like", as: :like, to: "likes#create"
      delete "unlike", as: :unlike, to: "likes#destroy"
    end 
    resources :users, only: [:index]
    resources :likes, only: [:create, :destroy]
  end  
  
  root "pages#index"
end
