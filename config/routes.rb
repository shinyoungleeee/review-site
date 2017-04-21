Rails.application.routes.draw do
  resources :memes do
    resources :reviews
  end

  root 'memes#index'
  get 'secret' => 'pages#secret'

  devise_for :users
end
