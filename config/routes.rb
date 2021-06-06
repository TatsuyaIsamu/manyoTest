Rails.application.routes.draw do
  root "tasks#index"
  resources :tasks
  resources :users, only: %i[show edit new create update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
