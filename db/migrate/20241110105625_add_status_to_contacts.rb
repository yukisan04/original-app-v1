class AddStatusToContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :contacts, :status, :string, default: 'active', null: false
  end
end