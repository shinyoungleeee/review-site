Rails.application.routes.draw do
  resources :memes do
    resources :reviews
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
