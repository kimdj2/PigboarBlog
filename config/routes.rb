Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope "/app", defaults: {format: :json} do
    resources :boards
    get 'taglist', {:format => :json}, to: 'tags#taglist'
    get 'archive', {:format => :json}, to: 'boards#archive'
    post 'auth_user', to: 'auth#authenticate_user'
    get 'get_auth', to: 'auth#get_auth'
  end
end
