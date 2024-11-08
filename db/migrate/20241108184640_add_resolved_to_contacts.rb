class AddResolvedToContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :contacts, :resolved, :boolean
  end
end
