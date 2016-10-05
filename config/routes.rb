Rails.application.routes.draw do



  resources :profiles
  get "about" => "pages#about", as: :about

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
  get 'upload', to: 'posts#new', as: :upload
  post '/posts/:id/play' => 'posts#play', as: :play

   scope ":id" do
    get '/', to: 'profiles#show', :as =>  :vanity_profile
    
  end

  get '/:username/:id', to: 'posts#show', as: :user_post




end
