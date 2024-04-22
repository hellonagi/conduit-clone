Rails.application.routes.draw do
  root 'articles#home'
  get '/editor', to: 'articles#editor'
  get '/editor/article-slug', to: 'articles#editor'
  get '/article/:slug', to: 'articles#show'
end
