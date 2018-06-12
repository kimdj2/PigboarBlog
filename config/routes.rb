Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get 'home/index'
  get 'home/authentication'
  
  resources :boards do
    resources :comments, except: [:index, :new, :show] do
      member do
        get :reply
      end
    end
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'main', to:'main#index'
  get 'intro', to:'intro#index'

  post '/tinymce_assets' => 'tinymce_assets#create'
  post '/image_upload' => 'images#create'

  get 'tags/:tag', to: 'boards#index', as: :tag
  get 'categories/:category', to:'boards#index', as: :category

  root "main#index"


end
