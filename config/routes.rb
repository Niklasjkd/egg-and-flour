Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'
  resources :recipes, only: [:show, :index]

  resources :profiles, only: [] do
    member do
      get "dashboard"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
