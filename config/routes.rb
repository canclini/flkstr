Flockstreet::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  # See how all your routes lay out with "rake routes"
  

  # tag list update of the company (special during website phase)
  
  match "/companies/:id/tags/add" => "companies#add_tag", :as => :add_tag_company, :via => :put
  match "/companies/:id/tags/:tag/remove" => "companies#remove_tag", :as => :remove_tag_company, :via => :delete

  match "/(:plan)/signup" => "companies#new", :as => :register, :plan => /scale|connect|ready/, :defaults => { :plan => 'ready' }
  
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "companies#new", :as => "register"
  
  resources :users, :sessions, :products, :updates, :settings, :price_suggestions, :password_resets
  
  resources :companies do
    get :tags, :on => :member
  end
  
   resources :requests do
     collection do
       delete :discard
       put :confirm_archive
       put :archive
     end
     member do
       put :recall
       put :assign
     end
   end
  
   
  # singular resource definition for search
  resource :search, :controller => 'search'
    
  resources :companies do
    get :exists, :on => :collection
    get :join, :on => :member
#    get :tags, :on => :member
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
  match "/impressum" => "website#impressum", :as => :impressum
  match "/terms" => "website#terms", :as => :terms
  match "/faq" => "website#faq", :as => :faq  
  match "(:locale)/plans" => "plans#index", :as => :plans, :locale => /de/
  
  # the famous root url
  match "/(:locale)" => "website#index", :as => :root, :locale => /de/
end
