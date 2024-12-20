class CreateMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade } # ここでカスケード削除を指定
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end