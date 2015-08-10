Rails.application.routes.draw do
  root to: 'employees#index'

  resources :employees do
    resources :certs
  end
end
