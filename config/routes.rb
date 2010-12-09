Flockstreet::Application.routes.draw do
  # See how all your routes lay out with "rake routes"
  
  # comment for website phase
  match "users/sign_in" => 'website#index' if $app_state == 'website'
  devise_for :users, :controllers => { :registrations => "users/registrations"}

  resources :products, :requests, :updates, :settings
  
  # singular resource definition for search
  resource :search, :controller => 'search'
    
  resources :companies do
    get :exists, :on => :collection
    get :join, :on => :member    
    get :autocomplete, :on => :collection
    resources :subscriptions
    resources :associates
  end
  
  resources :leads do
    get :actionbox, :on => :collection
    member do
      put :decline
      put :accept
    end
  end
  
  resources :tags do
    get :autocomplete, :on => :collection
  end
  
  resources :messages do
    get :reply, :on => :member
    collection do
      get :sent
      get :actionbox
    end
  end
  
  # twitter
  get "twitter/auth"
  get "twitter/signin"
  
  # dashboard
  match "/dashboard" => "dashboard#index", :as => :dashboard

  match "requests/filter/:status" => "requests#index", :as => :requests_filter, :via => "get"
  match "leads/filter/:status" => "leads#index", :as => :leads_filter, :via => "get"

  devise_for :users do
    match "/(:plan)/signup" => "users/registrations#new", :as => :register, :plan => /scale|connect|ready/, :defaults => { :plan => 'ready' }
  end
  
  # static tour pages
  get "tour/profile", :as => :tour_profile
  get "tour/leads", :as => :tour_leads
  get "tour/messages", :as => :tour_messages
  get "tour/notifications", :as => :tour_notifications
  get "tour/network", :as => :tour_network
  get "tour/request", :as => :tour_request
  get "tour/tags", :as => :tour_tags
  get "tour/updates", :as => :tour_updates

  # more static pages on the website
  match "/(:locale)/flockstreet" => "website#flockstreet", :as => :flockstreet, :locale => /de/
  match "/about" => "website#about", :as => :about
  match "/contact" => "website#contact", :as => :contact
  match "/terms" => "website#terms", :as => :terms
  match "/faq" => "website#faq", :as => :faq  
  match "(:locale)/plans" => "plans#index", :as => :plans, :locale => /de/
  
  # the famous root url
  match "/(:locale)" => "website#index", :as => :root, :locale => /de/
#  root :to => "website#index"

end
