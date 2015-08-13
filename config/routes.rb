Rails.application.routes.draw do
  root to: 'employees#index'

  # named routes
  get 'logout' => 'user_sessions#destroy'

  resources :employees do
    resources :certs
    resources :contacts
    resources :reprimands
  end

  resources :notes
  resources :reprimands
  resources :user_sessions
  resources :users
end
