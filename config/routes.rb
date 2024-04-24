Rails.application.routes.draw do
  root 'articles#index'
  get '/article/:slug', to: 'articles#show', as: 'article'
  get '/editor', to: 'articles#new'
  get '/editor/:slug', to: 'articles#edit'
  get '/register', to: 'users#new'
  get '/profile/:username', to: 'users#show', as: 'profile'
  get '/login', to: 'sessions#new'

  post '/api/articles', to: 'articles#create'
  patch '/api/articles/:slug', to: 'articles#update'
  delete '/api/articles/:slug', to: 'articles#destroy'
  post '/api/users', to: 'users#create'
  post   '/api/users/login',   to: 'sessions#create'
  delete '/api/users/logout',  to: 'sessions#destroy'
end
