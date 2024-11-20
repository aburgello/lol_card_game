Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
 end
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  root "champions#index"

    get 'add_skins', to: 'skins#add_skins'

  # Defines the root path route ("/")
  # root "posts#index"
  resources :regions, only: [:index, :show]
# config/routes.rb
resources :champions, param: :name, only: [:show, :index]

# Add a custom route for skin redirection
get 'champions/skin/:skin_name', to: 'champions#redirect_skin'


  # other routes
  resources :skins, only: [:index, :show] do
    resources :user_skins, only: [:create]
  end
resources :collections, only: [:index]
end
