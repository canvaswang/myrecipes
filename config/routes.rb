Rails.application.routes.draw do
  get 'pages/home'

  root 'pages#home'
  get  'pages/home', to: 'pages#home'

  # resources :recipes
  get '/recipes', to: 'recipes#index'
  get '/recipes/:id', to: 'recipes#show', as: 'recipe'
end
