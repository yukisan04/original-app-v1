# アプリケーション名
在庫ポケット

# アプリケーション概要
このアプリケーションは、家族や友人と在庫を共有・管理ができるアプリです。ユーザーはルームを作成し、アイテムの管理を行うことができます。

# ※機能はしますがまだ未完成です※
## URL : https://original-app-v1.onrender.com

# テスト用アカウント
- メールアドレス: sample1@sample.com
- 　パスワード　: Sample1

- メールアドレス: sample2@sample.com
- 　パスワード　: Sample2

# アプリケーションを作成した背景
自身が親に何々の在庫がないと言わないのでアプリにして管理できるようにすればいいのかなと思ってアプリを作りました

# 開発環境
- Ruby: 3.2.0
- Rails: 7.0.0
- HTML/CSS
- JavaScript
- PostgreSQL/MySQL
- RSpec

# 機能一覧

## ユーザー管理
- ユーザー登録、ログイン、ログアウト機能
- Deviseを使用した認証機能

## ルーム管理
- ルームの作成、参加、削除機能
- ルーム名やパスワードによるルームへの参加

## 在庫管理
- 在庫アイテムの追加、編集、削除機能
- 在庫数の自動管理機能
- アイテムには名称、数量、画像などを含めることが可能

## 買い物リスト機能
- 緊急度に基づくアイテムの分類
- アイテムの追加や編集が可能

## 参加者リスト
- ルーム内の参加者を表示する機能

## ダッシュボード
- ログイン後に表示されるダッシュボード

## テスト機能
- RSpecを使用したテストの実装

## エラーハンドリング
- エラーページでのコンソール表示などのデバッグ機能

## 画像処理
- アップロードした画像の処理や表示機能

# 実装予定の機能
・パスワードリセット機能を修正
・スマホでも見やすくなるようにする
・操作は簡単にできるようにする

# データベース設計
![データベース設計](https://github.com/user-attachments/assets/da00f408-0aa3-4c2b-93a2-ea138cf0ccc6)

# 画面遷移図
![画面遷移図](https://github.com/user-attachments/assets/04122bfb-a720-48e7-812b-67af11db807e)
# テーブル一覧

## users テーブル
| Column                 | Type      | Options                        |
|------------------------|-----------|--------------------------------|
| id                     | integer   | null: false, primary key       |
| email                  | string    | null: false                    |
| encrypted_password     | string    | null: false                    |
| reset_password_token   | string    |                                |
| reset_password_sent_at | datetime  |                                |
| remember_created_at    | datetime  |                                |
| created_at             | datetime  | null: false                    |
| updated_at             | datetime  | null: false                    |
| nickname               | string    |                                |

### Association
- has_many :room_users
- has_many :rooms, through: :room_users
- has_many :stocks

## rooms テーブル
| Column      | Type      | Options                        |
|-------------|-----------|--------------------------------|
| id          | integer   | null: false, primary key       |
| name        | string    | null: false                    |
| password    | string    | null: false                    |
| created_at  | datetime  | null: false                    |
| updated_at  | datetime  | null: false                    |

### Association
- has_many :room_users
- has_many :users, through: :room_users
- has_many :stocks

## stocks テーブル
| Column      | Type      | Options                        |
|-------------|-----------|--------------------------------|
| id          | integer   | null: false, primary key       |
| name        | string    | null: false                    |
| quantity    | integer   | default: 0, null: false        |
| room_id     | integer   | null: false                    |
| image       | string    |                                |
| created_at  | datetime  | null: false                    |
| updated_at  | datetime  | null: false                    |

### Association
- belongs_to :room

## room_users テーブル
| Column      | Type      | Options                        |
|-------------|-----------|--------------------------------|
| id          | integer   | null: false, primary key       |
| user_id     | integer   | null: false                    |
| room_id     | integer   | null: false                    |
| created_at  | datetime  | null: false                    |
| updated_at  | datetime  | null: false                    |

### Association
- belongs_to :user
- belongs_to :room
