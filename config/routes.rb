Rails.application.routes.draw do
  resources :movies do
    resources :comments, only: [:create]
  end
  
  devise_for :users
  
  get "up" => "rails/health#show", as: :rails_health_check
  
  root "movies#index"
end
