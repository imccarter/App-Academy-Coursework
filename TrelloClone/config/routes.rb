Rails.application.routes.draw do
  root to: "static_pages#index"
  resources :users, only: [:create, :new]
  resource :session, only: [:create, :new, :destroy]

  namespace :api, defaults: {format: :json} do
    resources :boards
    resources :lists
  end
end
