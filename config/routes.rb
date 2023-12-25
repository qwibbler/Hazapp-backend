Rails.application.routes.draw do
  devise_for :users
  resources :maslas
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  scope :api, defaults: { format: :json } do
    devise_for :users
  end

  # Defines the root path route ("/")
  root "maslas#index"
end
