Snorby::Application.routes.draw do

  devise_for :users, :path_names => { :sign_in => 'login', :sign_out => 'logout', :sign_up => 'register' }, :controllers => {:registrations => "registrations"} do
    get "/login", :to => "devise/sessions#new", :as => :login
    get "/logout", :to => "devise/sessions#destroy", :as => :logout
    get '/reset/password', :to => "devise/passwords#edit"
  end

  resources :users do
    collection do
      post :toggle_settings
      post :remove
      post :add
    end
  end

  # This feature is not ready yet
  # resources :notifications

  resources :jobs do
    member do
      get :last_error
      get :handler
    end
  end

  resources :classifications

  resources :sensors do
  end

  resources :settings do
    collection do
      get :restart_worker
      get :start_sensor_cache
      get :start_daily_cache
      get :start_worker
    end
  end

  resources :severities do

  end


  match '/dashboard', :controller => 'Page', :action => 'dashboard'
  match '/search', :controller => 'Page', :action => 'search'
  match '/results', :controller => 'Page', :action => 'results'

  match ':controller(/:action(/:sid/:cid))', :controller => 'Events'

  resources :events do

    resources :notes do

    end

    collection do
      get :view
      get :create_mass_action
      post :mass_action
      get :create_email
      post :email
      get :hotkey
      post :export
      get :lookup
      get :packet_capture
      get :history
      post :classify
      post :mass_update
      get :queue
      post :favorite
      get :last
      get :since
      get :activity
    end

  end

  resources :notes

  resources :page do
    collection do
      get :search
      get :results
    end
  end

  root :to => "page#dashboard"

end
