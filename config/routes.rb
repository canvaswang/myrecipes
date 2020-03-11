Rails.application.routes.draw do
  get 'pages/home'

  root 'pages#home'
  get  'pages/home', to: 'pages#home'

  # resources :recipes
  get '/recipes', to: 'recipes#index'
  post '/recipes', to: 'recipes#create'
  get '/recipes/new', to: 'recipes#new', as: 'new_recipe'
  get '/recipes/:id', to: 'recipes#show', as: 'recipe'
end
