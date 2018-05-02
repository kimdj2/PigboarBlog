Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  get 'home/authentication'

  resources :boards
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'main', to:'main#index'
  get 'intro', to:'intro#index'

  post '/tinymce_assets' => 'tinymce_assets#create'

  root "main#index"

end
