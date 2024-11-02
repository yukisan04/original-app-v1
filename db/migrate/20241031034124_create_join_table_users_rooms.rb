class CreateJoinTableUsersRooms < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :rooms do |t|
      # インデックスを追加して、検索効率を向上
      t.index :user_id
      t.index :room_id
    end
  end
end