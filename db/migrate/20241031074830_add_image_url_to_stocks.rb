class AddImageUrlToStocks < ActiveRecord::Migration[7.0]
  def change
    add_column :stocks, :image_url, :string
  end
end
