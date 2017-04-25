Rails.application.routes.draw do
  resources :memes do
    resources :reviews

    namespace :api do
      resource :reviews, only: [:show, :create, :update]
    end
  end

  namespace :api do
    resource :memes, only: [:show]
  end

  root 'memes#index'

  devise_for :users
end
