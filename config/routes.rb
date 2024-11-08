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

  resources :contacts, only: [:new, :create, :index] do
    member do
      post 'create_reply'  # 返信を作成するアクション
      get 'reply'  # 返信ページのルーティング
    end
  end

  resources :items
  resources :updaters, only: [:new, :create, :index, :edit, :update]
  resources :password_resets, only: [:new, :create, :index]
end
