Rails.application.routes.draw do
  # Active Storage routes
  direct :rails_storage do
    "#{Rails.configuration.active_storage.service_url_expires_in}"
  end

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Books resources
  resources :books
  
  # Defines the root path route ("/")
  root "books#index"
end
