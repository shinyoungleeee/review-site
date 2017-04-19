Rails.application.routes.draw do
  resources :memes

  root 'memes#index'

  get 'secret' => 'pages#secret'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
