Rails.application.routes.draw do
  root 'items#index'

  devise_for :users

  resources :contacts do
    member do
      get 'resolve'
      patch 'reopen'
    end
    resources :replies, only: [:create, :update, :edit, :show]
  end

  resources :rooms do
    member do
      post 'join'
    end
    resources :participants, only: [:index]
    resources :stocks, only: [:new, :create, :edit, :update, :destroy] do
      member do
        patch 'increment'
        patch 'decrement'
      end
    end
  end

  resources :items
  resources :updaters, only: [:new, :create, :index, :edit, :update]
  resources :password_resets, only: [:new, :create, :index]
end
