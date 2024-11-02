class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :memberships, dependent: :destroy # これにより、ユーザーが削除されたときに関連する membership も削除される
  has_many :rooms, through: :memberships

  validates :nickname, presence: true

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6, maximum: 128 }

  # 英字と数字の両方を含めることを確認する
  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: 'には英字と数字の両方を含めて半角で設定してください' }

  validate :password_cannot_be_full_width
  validate :password_cannot_be_numeric_only

  private

  # パスワードが全角の場合、エラーを追加する
  def password_cannot_be_full_width
    if password.present? && password.match?(/\A[^\x01-\x7E]+\z/) # 全角文字の正規表現
      errors.add(:password, 'には英字と数字の両方を含めて半角で設定してください')
    end
  end

  # パスワードが数字のみの場合、エラーを追加する
  def password_cannot_be_numeric_only
    if password.present? && password.match?(/\A\d+\z/) # 数字のみの正規表現
      errors.add(:password, 'には英字と数字の両方を含めて半角で設定してください')
    end
  end
end
