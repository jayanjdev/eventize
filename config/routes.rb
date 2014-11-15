Rails.application.routes.draw do
  get 'anglr_app/index'

  get 'graphs/events'

  get '/events_graph', to: 'events#search'
  get '/top_events', to: 'events#top_events'

  resources :events do 
    resources :tags 
  end

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users do
  end
  
end
