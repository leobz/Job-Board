Rails.application.routes.draw do
  root :to => "jobs#index"

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"

  resources :sessions
  resources :jobs
  resources :companies

  post '/invoices/create', to: 'invoices#create'
  post '/invoices/webhook', to: 'invoices#webhook'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
