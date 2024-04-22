Rails.application.routes.draw do
  root 'articles#index', as: 'articles'
  get '/editor', to: 'articles#new', as: 'new_article'
  get '/editor/:slug', to: 'articles#edit', as: 'edit_article'
  get '/article/:slug', to: 'articles#show', as: 'article'
  post '/api/articles', to: 'articles#create', as: 'create_article'
  patch '/api/articles/:slug', to: 'articles#update', as: 'update_article'
  delete '/api/articles/:slug', to: 'articles#destroy', as: 'destroy_article'
end
