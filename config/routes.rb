Rails.application.routes.draw do
  
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }

  resources :tags do
    resources :gems, only: [:index]
  end

  resources :users, path: :devs do
    resources :gems, only: [:index]
  end  
  
  resources :gems do
    member do
      post "like", as: :like, to: "gems#like"
    end 
    resources :users, only: [:index]
    resources :likes, only: [:create, :destroy]
  end  
  
  get "/", to: "pages#index", as: :home
  get "/profile", to: "users#profile", as: :profile
  get "/health", to: "pages#health", as: :health
  get "/about", to: "pages#about", as: :about
  
  match "bad-request", to: "errors#bad_request", as: "bad_request", via: :all
  match "not_authorized", to: "errors#not_authorized", as: "not_authorized", via: :all
  match "route-not-found", to: "errors#route_not_found", as: "route_not_found", via: :all
  match "resource-not-found", to: "errors#resource_not_found", as: "resource_not_found", via: :all
  match "missing-template", to: "errors#missing_template", as: "missing_template", via: :all
  match "not-acceptable", to: "errors#not_acceptable", as: "not_acceptable", via: :all
  match "unknown-error", to: "errors#unknown_error", as: "unknown_error", via: :all
  match "service-unavailable", to: "errors#service_unavailable", as: "service_unavailable", via: :all

  match '/400', to: 'errors#bad_request', via: :all
  match '/401', to: 'errors#not_authorized', via: :all
  match '/403', to: 'errors#not_authorized', via: :all
  match '/404', to: 'errors#resource_not_found', via: :all
  match '/406', to: 'errors#not_acceptable', via: :all
  match '/422', to: 'errors#not_acceptable', via: :all
  match '/500', to: 'errors#unknown_error', via: :all

  get '/sitemap.xml.gz', to: redirect("https://#{ENV['AWS_BUCKET_NAME']}.s3.amazonaws.com/sitemaps/sitemap.xml.gz")
  get '/sitemaps/sitemap.xml.gz', to: redirect("https://#{ENV['AWS_BUCKET_NAME']}.s3.amazonaws.com/sitemaps/sitemap.xml.gz")

  root "pages#index"
  
  match '*path', to: 'errors#route_not_found', via: :all
  
end
