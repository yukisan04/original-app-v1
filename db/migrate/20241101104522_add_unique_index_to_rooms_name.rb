class AddUniqueIndexToRoomsName < ActiveRecord::Migration[7.0]
  def change
    add_index :rooms, :name, unique: true
  end
end