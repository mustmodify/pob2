Rails.application.routes.draw do
  root to: 'pages#dashboard'

  get 'calendar' => 'reports#calendar'
  # named routes
  get 'logout' => 'user_sessions#destroy'

  match '/reports/:action', to: 'reports', via: [:get, :post]

  resources :cert_names
  resources :customers
  resources :departure_sites

  resources :employees do
    resources :certs
    resource :cert_email
    resources :competencies
    resources :compliments
    resources :contacts
    resources :jobs
    resources :reprimands
    resources :restrictions
    resources :screenings
  end

  resources :jobs do
    resources :change
  end

  resources :notes
  resources :oil_cos
  resources :positions do
    resources :customary_certs, shallow: true
  end

  resources :projects do
    resources :assignments
    resources :jobs
  end

  resources :reprimands
  resource :search
  resources :user_sessions
  resources :users
  resources :work_sites
end
