Rails.application.routes.draw do
  resources :posts
  mount Upmin::Engine => '/admin'
  root to: 'posts#index'
  devise_for :users
  resources :users

  get "/posts/:id/embed" => "posts#embed", as: :embed
  get 'artist/:artist', to: 'posts#artist', as: :artist
  get 'track/:track', to: 'posts#track', as: :track
  get '/buy', to: 'posts#buy', as: :buy
  get 'tagged/:tag', to: 'posts#tag', as: :tag


end
