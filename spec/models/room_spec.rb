require 'rails_helper'

RSpec.describe Room, type: :model do
  describe "ルームの新規作成" do
    it "全ての項目が正しく存在すれば登録できる" do
      user = FactoryBot.create(:user)  # ユーザーを作成
      room = Room.new(
        name: "Sample Room",
        password: "samplepassword",
        description: "Sample room description"
      )
      room.users << user  # 作成したユーザーをルームに追加

      expect(room).to be_valid
    end

    it "関連するユーザーがいる場合は登録できる" do
      user = FactoryBot.create(:user)  # ユーザーを作成
      room = Room.new(
        name: "Sample Room",
        password: "samplepassword",
        description: "Sample room description"
      )
      room.users << user  # 作成したユーザーをルームに追加

      expect(room).to be_valid
    end

    it "ルーム名が空では登録できない" do
      room = Room.new(
        name: nil,
        password: "samplepassword",
        description: "Sample room description"
      )
      room.users << FactoryBot.create(:user)  # ユーザーを追加

      expect(room).to_not be_valid
      expect(room.errors[:name]).to include("can't be blank")
    end

    it "パスワードが空では登録できない" do
      room = Room.new(
        name: "Sample Room",
        password: nil,
        description: "Sample room description"
      )
      room.users << FactoryBot.create(:user)  # ユーザーを追加

      expect(room).to_not be_valid
      expect(room.errors[:password]).to include("can't be blank")
    end

    it "同じルーム名が存在する場合は登録できない" do
      existing_room = Room.create(
        name: "Duplicate Room",
        password: "samplepassword",
        description: "Description for duplicate room"
      )
      room = Room.new(
        name: existing_room.name,
        password: "anotherpassword",
        description: "Another room description"
      )
      room.users << FactoryBot.create(:user)  # ユーザーを追加

      expect(room).to_not be_valid
      expect(room.errors[:name]).to include("has already been taken")
    end
  end
end
