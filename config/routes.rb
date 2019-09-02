Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :recipes, only: [:index, :create]

   resources :requests, only: [:index, :show] do
     resources :meetups, only: [:show, :create, :new]
  end

  resources :profiles, only: [] do
    member do
      get "dashboard"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
