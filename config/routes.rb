Rails.application.routes.draw do
  get 'anglr_app/index'

  resources :events do 
    resources :tags 
  end

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  
end
