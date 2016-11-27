Rails.application.routes.draw do

  mount Upmin::Engine => '/admin'
  resources :profiles
  get "about" => "pages#about", as: :about
  get "terms" => "pages#terms", as: :terms
  get "privacy" => "pages#privacy", as: :privacy

  resources :posts

  resources :posts do
    member do
      get :download
    end
  end  


  devise_for :users
  resources :users



  get "/popular" => "posts#index", as: :popular
  get "/latest" => "posts#latest", as: :latest
  get "/posts/:id/embed" => "posts#embed", as: :embed
  get "/posts/:id/player" => "posts#player", as: :player
  get "/posts/:id/card" => "posts#card", as: :card
  get 'artist/:artist', to: 'posts#artist', as: :artist
  get 'track/:track', to: 'posts#track', as: :track
  get '/buy', to: 'posts#buy', as: :buy
  get 'tagged/:tag', to: 'posts#tag', as: :tag
  get 'featured', to: 'posts#featured', as: :featured
  get 'upload', to: 'posts#new', as: :upload
  post '/posts/:id/play' => 'posts#play', as: :play
  post '/posts/:id/download' => 'posts#download', as: :download

  post 'user_favs' => 'user_favs#create', :as => 'user_favs'
  delete 'user_favs' => 'user_favs#destroy', :as => 'delete_user_favs'



  scope ":id" do

    get "/followers" => "profiles#followers", as: :followers
    post "/follow" => "profiles#follow", as: :follow
    delete "/unfollow" => "profiles#unfollow", as: :unfollow

    get '/', to: 'profiles#show', :as =>  :vanity_profile
    get '/favorites', to: 'profiles#favorites', as: :user_favorites
    
  end

  get '/:username/:id', to: 'posts#show', as: :user_post

  authenticated :user do
    #root to: 'posts#index'
    root to: 'visitors#index'
  end

  unauthenticated do
    root to: 'visitors#index', as: :welcome
  end


end
