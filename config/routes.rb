Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope "/app", defaults: {format: :json} do
    resources :boards
    get 'taglist', {:format => :json}, to: 'tags#taglist'
    get 'archive', {:format => :json}, to: 'boards#archive'
    get 'recent_posts', {:format => :json}, to: 'boards#recent_posts'
    post 'auth_user', to: 'auth#authenticate_user'
    post 'upload_image', to: 'images#upload_image'
    get 'get_auth', to: 'auth#get_auth'

  end
end
