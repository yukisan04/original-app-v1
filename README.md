# 在庫管理アプリケーション

このアプリケーションは、家族や友人と共有できる在庫管理システムです。ユーザーはルームを作成し、アイテムの管理を行うことができます。

# ※まだ未完成です※
## URL : https://original-app-v1.onrender.com

# 機能一覧

## ユーザー管理

ユーザー登録（ニックネーム、メールアドレス）
ログイン/ログアウト
アカウント編集（ニックネーム変更）
ルーム管理

## ルームの作成

ルームへの参加（パスワード認証）
ルームの一覧表示
ルームの削除

## 在庫管理

在庫の追加
在庫の一覧表示
在庫の編集
在庫の削除
在庫の自動更新（数量変更）

## 在庫リスト機能

商品名、数量、画像を管理
緊急度に応じた分類


## users テーブル
| Column             | Type      | Options                        |
| -------------------| ----------| -------------------------------|
| nickname           | string    | null: false                    |
| email              | string    | null: false, unique: true      |
| encrypted_password | string    | null: false                    |

### Association
- has_many :items
- has_many :orders

## rooms テーブル
| Column             | Type      | Options                        |
| -------------------| ----------| -------------------------------|
| name               | string    | null: false                    |
| password           | string    | null: false                    |
| user_id            | integer   | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_many :stocks

## stocks テーブル
| Column             | Type      | Options                        |
| -------------------| ----------| -------------------------------|
| name               | string    | null: false                    |
| quantity           | integer   | null: false                    |
| room_id            | integer   | null: false, foreign_key: true |
| image_url          | string    |                                |

### Association
- belongs_to :room