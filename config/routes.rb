Rails.application.routes.draw do
  root to: 'employees#index'

  # named routes
  get 'logout' => 'user_sessions#destroy'
  get 'ssns', to: 'pages#ssns'

  resources :assignments
  resources :cert_names
  resources :customers

  resources :employees do
    resources :certs
    resource :cert_email
    resources :competencies
    resources :compliments
    resources :contacts
    resources :reprimands
    resources :restrictions
    resources :screenings
  end

  resources :notes
  resources :ops_notes
  resources :positions do
    resources :customary_certs, shallow: true
  end

  resources :projects

  resources :reprimands
  resource :search
  resources :user_sessions
  resources :users
end
