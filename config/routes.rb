Rails.application.routes.draw do
  root 'articles#index'
  get '/article/:slug', to: 'articles#show', as: 'article'
  get '/editor', to: 'articles#new'
  get '/editor/:slug', to: 'articles#edit', as: 'edit_article'
  get '/register', to: 'users#new'
  get '/profile/:username', to: 'users#show', as: 'profile'
  get '/settings', to: 'users#edit'
  get '/login', to: 'sessions#new'

  post '/api/articles', to: 'articles#create', as: 'post_article'
  patch '/api/articles/:slug', to: 'articles#update', as: 'patch_article'
  delete '/api/articles/:slug', to: 'articles#destroy', as: 'delete_article'
  post '/api/users', to: 'users#create'
  patch '/api/user', to: 'users#update'
  post   '/api/users/login',   to: 'sessions#create'
  delete '/api/users/logout',  to: 'sessions#destroy'
end
