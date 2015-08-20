Rails.application.routes.draw do
  root to: 'employees#index'

  # named routes
  get 'logout' => 'user_sessions#destroy'

  resources :crew_changes
  resources :customers
  resources :departure_sites

  resources :employees do
    resources :certs
    resources :competencies
    resources :compliments
    resources :contacts
    resources :reprimands
    resources :restrictions
  end

  resources :notes
  resources :oil_cos
  resources :positions
  resources :projects do
    resources :crew_changes
  end

  resources :reprimands
  resources :user_sessions
  resources :users
  resources :work_sites
end
