class Stock < ApplicationRecord
  belongs_to :room
  has_one_attached :image  # 画像を添付するための設定
  validates :product_name, presence: true
  validates :quantity, presence: true
  def stock_status
    case quantity
    when 0
      '在庫なし'
    when 1..5
      '在庫少なめ'
    else
      '在庫あり'
    end
  end

  def generate_image
    # ここに画像を生成するロジックを実装します。
    # 例えば、OpenAI APIや他の画像生成サービスを利用することができます。
    # 以下は単なるサンプルで、実際の実装には適切なAPI呼び出しを行ってください。

    product_name = self.product_name
    "https://example.com/generated_image_for_#{product_name}.png"
  end
end