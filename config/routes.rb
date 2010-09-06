Flockstreet::Application.routes.draw do
  # See how all your routes lay out with "rake routes"

  devise_for :users, :controllers => { :registrations => "users/registrations"}

  resources :products, :requests, :updates  
  
  resources :leads do
    member do
      put :decline
      put :accept
    end
  end

  resources :companies do
    collection do
      get :exists
    end
    member do
      get :join
    end
    resources :subscriptions
#      resources :associates
  end
  root :to => "website#index"
  match "/dashboard" => "dashboard#index", :as => :dashboard

  match "/companies/:company_id/subscriptions/:plan/new" => "subscriptions#new", :as => :new_company_subscription,  :via => "get"
  
  # static website pages
  get "website/index"
  get "website/about"
  get "website/terms"
  get "website/faq"
  get "website/contact"

  # static tour pages
  get "tour/profile", :as => :tour_profile
  get "tour/leads", :as => :tour_leads
  get "tour/messages", :as => :tour_messages
  get "tour/notifications", :as => :tour_notifications
  get "tour/network", :as => :tour_network
  get "tour/request", :as => :tour_request
  get "tour/tags", :as => :tour_tags
  get "tour/updates", :as => :tour_updates
  
  match "/about" => "website#about", :as => :about
  match "/contact" => "website#contact", :as => :contact
  match "/terms" => "website#terms", :as => :terms
  match "/faq" => "website#faq", :as => :faq
  
  get "plans/index"
  
  # bei einem signup muss erst der Plan gewählt werden
  match "/signup" => "plans#index", :as => :signup
  #ist der Plan gewählt, wird die Firma erfasst
  match "/signup(/:plan)" => "companies#new", :as => :signup
  #ist die Firma erfasst und der Plan gewählt, kommt die User registrierung
  devise_for :users do
    match "/signup/:company/user/new" => "users/registrations#new", :as => :register
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get :recent, :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"
end
