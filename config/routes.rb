Rails.application.routes.draw do
  resources :memes do
    resources :reviews
  end

  resources :admins, only: [:index, :destroy] do
    get '/make_admin', to: 'admins#make_admin'
    get '/remove_admin', to: 'admins#remove_admin'
  end

  namespace :api do
    namespace :v1 do
      resources :memes, only: [:show] do
        resources :reviews, only: [:index, :update, :destroy]
      end
    end
  end

  root 'memes#index'

  devise_for :users
end
