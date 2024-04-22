Rails.application.routes.draw do
  root 'articles#index'
  get '/article/:slug', to: 'articles#show'
  get '/editor', to: 'articles#new'
  get '/editor/:slug', to: 'articles#edit'

  namespace :api do
    post '/articles', to: 'articles#create'
    patch '/articles/:slug', to: 'articles#update'
    delete '/articles/:slug', to: 'articles#destroy'
  end
end
