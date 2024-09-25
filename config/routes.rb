Rails.application.routes.draw do
  root to: 'employees#index'

  # named routes
  get 'logout' => 'user_sessions#destroy'
  get 'ssns', to: 'pages#ssns'
  get 'ops', to: 'pages#ops'

  resources :assignments
  resources :cert_names
  resources :clients
  resources :customers

  resources :employees do
    resources :certs
    resource :cert_email
    resources :competencies
    resources :compliments
    resources :contacts
    resource :history, controller: :employment_actions
    resources :reprimands
    resources :restrictions
    resources :screenings
    resources :time_entries
    resource :time_analysis
  end

  resources :employment_actions
  resources :notes
  resources :ops_notes
  resources :positions do
    resources :customary_certs, shallow: true
  end

  resources :projects do
    get 'inactive', on: :collection
  end

  resources :reprimands
  resource :search
  resource :time_analysis
  resources :time_entries
  resources :user_sessions
  resources :users
end
