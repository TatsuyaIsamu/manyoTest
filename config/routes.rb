Rails.application.routes.draw do
  get 'sessions/new'
  root "tasks#index"
  resources :tasks
  resources :users, only: %i[show edit new create update]
  resources :sessions, only: %i[new create destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
