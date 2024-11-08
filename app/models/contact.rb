class Contact < ApplicationRecord
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :content, presence: true
  belongs_to :user, optional: true
  has_many :replies, dependent: :destroy
end
