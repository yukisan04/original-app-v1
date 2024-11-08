class CreateReplies < ActiveRecord::Migration[7.0]
  def change
    create_table :replies do |t|
      t.references :contact, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
