class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :email
      t.text :content
      t.string :phone_number

      t.timestamps
    end
  end
end
