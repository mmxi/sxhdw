Sxhdw::Application.routes.draw do
  resources :user_sessions
  resources :users, :only => [:show, :new, :create]
  resources :forums do
    resources :topics
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

  namespace "setting" do
    resource :account, :controller => :users do
      get :change_password, :on => :member
      put :change_password, :on => :member
    end
  end

  namespace "admin" do
    resources :activities, :path => :events
    resources :sites do
      get :set_default_site, :on => :member
    end
    resources :forums
  end
  
  root :to => "forums#index"
  match ':controller(/:action(/:id(.:format)))'
end
