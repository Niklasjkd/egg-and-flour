Rails.application.routes.draw do
  get 'requests/index'
  get 'recipes/show'
  get 'recipes/index'
  devise_for :users
  root to: 'pages#home'
  resources :recipes, only: [:show, :index] do
    resources :requests, only: [:index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
