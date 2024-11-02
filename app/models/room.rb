class Room < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :stocks, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :password_digest, presence: true, if: -> { password.present? }
  validates :description, presence: true, allow_blank: true

  attr_accessor :password # passwordをattr_accessorで定義

  before_save :encrypt_password

  # パスワードの確認メソッド
  def valid_password?(input_password)
    return false if password_digest.blank?
    BCrypt::Password.new(password_digest) == input_password
  end

  private

  def encrypt_password
    if password.present?
      self.password_digest = BCrypt::Password.create(password)
    end
  end
end
