Rails.application.routes.draw do
  root 'articles#index'
  get '/article/:slug', to: 'articles#show', as: 'article'
  get '/editor', to: 'articles#new'
  get '/editor/:slug', to: 'articles#edit'

  post '/api/articles', to: 'articles#create'
  patch '/api/articles/:slug', to: 'articles#update'
  delete '/api/articles/:slug', to: 'articles#destroy'
end
