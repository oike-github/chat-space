Rails.application.routes.draw do
  devise_for :users
  root to: 'groups#index'
  resources :users, only: [:edit, :update]
  resources :groups, onry: [:new, :create, :edit, :update] do
    resources :messages, onry: [:index, :create]
  end
end
