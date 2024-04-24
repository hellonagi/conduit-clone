Rails.application.routes.draw do
  get 'users/new'
  root 'articles#index'
  get '/article/:slug', to: 'articles#show', as: 'article'
  get '/editor', to: 'articles#new'
  get '/editor/:slug', to: 'articles#edit'
  # get '/login'
  get '/register', to: 'users#new'
  get '/profile/:username', to: 'users#show', as: 'profile'

  post '/api/articles', to: 'articles#create'
  patch '/api/articles/:slug', to: 'articles#update'
  delete '/api/articles/:slug', to: 'articles#destroy'
  # post '/api/users/login', tp: ''
  post '/api/users', to: 'users#create'
end
