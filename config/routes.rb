Rails.application.routes.draw do
  get 'recipes/show'
  get 'recipes/index'
  devise_for :users
  root to: 'pages#home'
  resources :recipes, only: [show:, index:]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
