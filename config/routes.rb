Rails.application.routes.draw do
  root 'items#index'

  devise_for :users  # Deviseのデフォルトの設定を使用

  resources :rooms do
    collection do
      post 'join'
    end
    resources :participants, only: [:index]  # 参加者一覧のルートを追加
    resources :stocks, only: [:new, :create, :edit, :update, :destroy] do
      member do
        patch 'increment'
        patch 'decrement'
      end
    end
  end

  resources :items

  # Contactsリソースを追加
  resources :contacts, only: [:new, :create]

  # パスワードリセットのルーティングを追加
  resources :password_resets, only: [:new, :create, :index]
end
