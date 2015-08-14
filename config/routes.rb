Rails.application.routes.draw do
  root to: 'employees#index'

  # named routes
  get 'logout' => 'user_sessions#destroy'

  resources :heliports

  resources :employees do
    resources :certs
    resources :competencies
    resources :contacts
    resources :reprimands
  end

  resources :notes
  resources :oil_cos
  resources :positions
  resources :reprimands
  resources :user_sessions
  resources :users
  resources :yards
end
