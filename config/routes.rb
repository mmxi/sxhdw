Sxhdw::Application.routes.draw do
  
  get "activations/create"

  resources :user_sessions
  resources :users do
    member do
      get :change_password
      put :change_password
    end
  end
  
  resources :activities, :path => :events, :only => [:index, :show, :join] do
    member do
      get :join
      get :interest
    end
  end

  match "/signup" => "users#new", :as => :signup
  match "/login" => "user_sessions#new",      :as => :login
  match "/logout" => "user_sessions#destroy", :as => :logout
  
  match "auth/:provider/callback", :to => "authorizations#create"
  match "auth/failure", :to => "authorizations#failure"
  match "user/bind", :to => "users#bind", :as => :user_bind
  match "user/login", :to => "users#login", :as => :user_login
  match "/activate/:activation_code", :to => "activations#create", :as => :activate
  
  namespace "admin" do
    resources :activities, :path => :events
  end
  root :to => "home#index"
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
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
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
  #       get 'recent', :on => :collection
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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id(.:format)))'
end
