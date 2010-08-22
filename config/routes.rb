Flockstreet::Application.routes.draw do
  # See how all your routes lay out with "rake routes"
  devise_for :users, :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => "register"}
  resources :products, :companies, :requests, :leads, :companies

#  resources :leads do
#    member do
#      put :decline
#      put :accept
#    end
#  end

#  resources :companies do
#      member do
#        get :products
#        get :requests
#        get :staff
#      end
#      collection do
#        get :search
#      end
#      resources :associates
#    end
  root :to => "website#index"
  
  get "website/index"
  get "website/about"
  get "website/agb"
  get "website/contact"
  get "plans/index"

  match "/about" => "website#about", :as => :about
  match "/contact" => "website#contact", :as => :contact
  match "/agb" => "website#agb", :as => :agb
  match "/dashboard" => "dashboard#index", :as => :dashboard
  
  # bei einem signup muss erst der Plan gewählt werden
  match "/signup" => "plans#index", :as => :signup
  #ist der Plan gewählt, wird die Firma erfasst
  match "/signup(/:plan)" => "companies#new", :as => :signup
  
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
  #     end
  #   end

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
