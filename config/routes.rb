Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    resources :clients, only: [:index,:show,:create,:update]
    resources :providers, only: [:index,:show,:create,:update]
    resources :users, only: [:index,:show,:create, :update]
    resources :user_types, only: [:index,:show]

    post "users/authenticate", to: "users#authenticate"
  end

  
end
