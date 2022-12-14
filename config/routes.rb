Rails.application.routes.draw do
  resources :maslas do
    resources :pre_maslas
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "maslas#index"
end
