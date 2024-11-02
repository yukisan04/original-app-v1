class AddExternalImageUrlToStocks < ActiveRecord::Migration[7.0]
  def change
    add_column :stocks, :external_image_url, :string
  end
end
