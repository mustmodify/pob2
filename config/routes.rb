Rails.application.routes.draw do
  root to: 'employees#index'

  resources :employees do
    resources :certs
    resources :reprimands
  end
  resources :reprimands
end
