class AddLastAccessedAtToMemberships < ActiveRecord::Migration[7.0]
  def change
    add_column :memberships, :last_accessed_at, :datetime
  end
end
