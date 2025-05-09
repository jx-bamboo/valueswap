Rails.application.routes.draw do

  resources :profile, except: %i[show new create edit update destroy] do 
    collection do
      get :index
      get :invite
      get :record
      get :ex_form
      post :create_user_exchange
      get :apply_address
    end
  end

  resources :exchange_balances
  resources :exchange_coins do 
    collection do
      get "coins_for_exchange"
    end
  end
  resources :operation_logs
  resources :airdrops
  resources :funds
  resources :transfers
  resources :addresses

   get '/user_exchanges/by_user', to: 'user_exchanges#by_user'
  
  resources :trades do
    get '/exchanges_by_user', to: 'trades#exchanges_by_user'
    get '/coins_by_exchange', to: 'trades#coins_by_exchange'

    collection do
      get 'exchanges_for_user/:user_id', to: 'trades#exchanges_for_user'
      get 'coins_for_user_exchange/:user_exchange_id', to: 'trades#coins_for_user_exchange'
      get 'coin_info/:user_exchange_id/:coin_id', to: 'trades#coin_info'
      get 'open'
      post 'open_create'
      get 'assets_by_user_exchange/:user_exchange_id', to: 'trades#assets_by_user_exchange'
      get 'assets_for_user_exchange/:user_exchange_id', to: 'trades#assets_for_user_exchange'
    end 
   
  end

  resources :coins
  resources :exchanges
  resources :user_exchanges do 
    collection do
      get 'add_exchange_balance'
    end
  end

  resources :user_exchange_coins do
    collection do
      # get 'for_user/:user_id', to: 'user_exchange_coins#for_user'
      get 'exchanges_for_user/:user_id', to: 'user_exchange_coins#exchanges_for_user'
      get 'coins_for_exchange/:exchange_id', to: 'user_exchange_coins#coins_for_exchange'
    end
  end

  # resources :user_exchanges do
  #   resources :user_exchange_coins, only: [:index, :new, :create, :edit, :update, :destroy]
  # end

  namespace :admin do
    get "user/index"
    resources :dashboard, except: %i[show new create edit update destroy] do
			collection do
        get :index
				get :real_time
			end
    end
  end

	devise_for :users, controllers: {
		sessions: 'users/sessions',
		registrations: 'users/registrations'
	}
  # devise_for :users
  resources :home, only: [:index] do
    collection do
      get :index
      get :test_login
      get :test_sign
      get :test_back
      get :airdrop
      get :fund
      get :reward
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
end
