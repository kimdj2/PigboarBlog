Rails.application.routes.draw do
  get 'contact/create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'users/sessions' }
  #devise_for :users, :controllers => {}

  #get
  get 'main', to:'main#index'
  get 'feed', to:'main#feed'
  get 'tags/:tag', to: 'boards#index', as: :tag
  get 'created/:created', to: 'boards#index', as: :created
  get 'categories/:category', to:'boards#index', as: :category
  get 'about', to:'etc#about'
  
  #post
  post '/image_upload' => 'images#create'
  post '/contact/send' => 'contact#create'
  resources :boards do
    resources :likes, only: [:create, :destroy]
  end

  resources :boards do
    resources :comments, except: [:index, :new, :show] do
      member do
        get :reply
      end
    end
  end
  
  root "main#index"


end
