Rails.application.routes.draw do


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

  mount Upmin::Engine => '/admin'
  devise_for :users
  resources :users


  get "/posts/:id/embed" => "posts#embed", as: :embed
  get "/posts/:id/player" => "posts#player", as: :player
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

  authenticated :user do
    root to: 'posts#index'
    # root to: 'pages#welcome'
  end

  unauthenticated do
    root to: 'visitors#index', as: :welcome
  end


end
