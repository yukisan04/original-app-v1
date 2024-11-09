class Contact < ApplicationRecord
  has_many :replies, dependent: :destroy
  belongs_to :user

  enum status: { open: 0, closed: 1, reopened: 2 }

  validates :email, presence: true
  validates :content, presence: true
end