class ParticipantsController < ApplicationController
  def index
    @room = Room.find(params[:room_id])  # ルームIDに基づいてルームを取得
    @participants = @room.users            # ルームの参加者を取得
  end
end