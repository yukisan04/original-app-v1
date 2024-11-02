FactoryBot.define do
  factory :room do
    name { "Sample Room" }
    password { "password" }
    description { "Sample room description" }

    # associationsを明示的に追加
    after(:build) do |room|
      # roomに関連するユーザーを作成し、そのユーザーをMembershipに追加
      user = FactoryBot.create(:user)  # ユーザーを作成
      room.memberships << FactoryBot.build(:membership, user: user, room: room)  # Membershipを追加
    end
  end
end
