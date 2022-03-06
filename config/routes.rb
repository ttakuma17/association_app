Rails.application.routes.draw do
  # get 'relationships/create'
  # get 'relationships/destroy'
  # get 'favorites/create'
  # get 'favorites/destroy'
  root 'tweets#index'

  # get 'tweets/new'
  # get 'tweets/index'
  # get 'tweets/show'
  # get 'tweets/create'
  # get 'users/index'
  # get 'users/show'

  devise_for :users
  resources :tweets do
    resource :favorites, only: [:create, :destroy]
  end

  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
