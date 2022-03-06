Rails.application.routes.draw do
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

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
