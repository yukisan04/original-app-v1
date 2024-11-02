class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :product_name, null: false # 商品名
      t.integer :quantity, default: 0      # 在庫数のデフォルト値を0に設定
      t.string :image                        # 画像のカラム
      t.references :room, null: false, foreign_key: true # ルームの参照

      t.timestamps
    end
  end
end
