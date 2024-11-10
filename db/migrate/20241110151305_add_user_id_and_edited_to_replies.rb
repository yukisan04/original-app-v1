class AddUserIdAndEditedToReplies < ActiveRecord::Migration[7.0]
  def change
    add_column :replies, :user_id, :integer
    add_column :replies, :edited, :boolean, default: false
  end
end