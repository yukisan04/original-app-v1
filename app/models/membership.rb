class Membership < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :user, presence: { message: "ユーザーは必須です。" }
  validates :room, presence: { message: "ルームは必須です。" }
  validates :user_id, uniqueness: { scope: :room_id, message: "このルームにはすでに参加しています。" }
end