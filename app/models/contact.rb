class Contact < ApplicationRecord
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :content, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{3}-\d{4}-\d{4}\z/, message: "は正しい形式で入力してください（例: 090-1234-5678）" }
end
