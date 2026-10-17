Rails.application.routes.draw do
  root "home#show"

  get "login", to: "sessions#new", as: :login
  delete "logout", to: "sessions#destroy", as: :logout
  get "auth/:provider/callback", to: "sessions#create"
  get "auth/failure", to: "sessions#failure"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check
end
