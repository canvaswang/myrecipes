Rails.application.routes.draw do
  root 'pages#home'
  get  'pages/home', to: 'pages#home'

  resources :recipes

  get 'signup', to: 'chefs#new'

  get 'chefs', to: 'chefs#index'
  post 'chefs', to: 'chefs#create'
  get 'chefs/:id/edit', to: 'chefs#edit', as: 'edit_chef'
  get 'chefs/:id', to: 'chefs#show', as: 'chef'
  patch 'chefs/:id', to: 'chefs#update'
end
