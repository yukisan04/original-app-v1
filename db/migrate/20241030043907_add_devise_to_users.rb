class AddDeviseToUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      # t.string :email,              null: false, default: ""   # コメントアウトまたは削除
      # t.string :encrypted_password, null: false, default: ""   # コメントアウトまたは削除
      # t.string :reset_password_token                           # コメントアウトまたは削除
      # t.datetime :reset_password_sent_at                       # コメントアウトまたは削除
      # t.datetime :remember_created_at                          # コメントアウトまたは削除

      # t.index :email, unique: true                             # コメントアウトまたは削除
      # t.index :reset_password_token, unique: true              # コメントアウトまたは削除
    end
  end
end
