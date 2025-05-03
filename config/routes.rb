Rails.application.routes.draw do
  # Active Storage routes
  direct :rails_storage do
    "#{Rails.configuration.active_storage.service_url_expires_in}"
  end

  # Devise routes for authentication
  devise_for :users

  # Authenticated routes
  authenticate :user do
    resources :books
    root 'books#index', as: :authenticated_root
  end

  # Public routes
  unauthenticated do
    root 'devise/sessions#new'
  end

  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
