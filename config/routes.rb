Rails.application.routes.draw do
  get 'anglr_app/index'

  resources :events do 
     put 'tag_destroy', :controller => :tags, :action => :destroy, :on => :member
     put 'tag_update', :controller => :tags, :action => :update, :on => :member
  end

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  
end
