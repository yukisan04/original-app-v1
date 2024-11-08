class Contact < ApplicationRecord
  belongs_to :user
  has_many :replies, dependent: :destroy
  enum status: { open: 0, closed: 1 } # 問い合わせの状態（open: 解決していない、closed: 解決済み）

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :content, presence: true
end