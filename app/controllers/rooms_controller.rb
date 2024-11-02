class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    @rooms = Room.joins(:memberships)
                 .where(memberships: { user_id: current_user&.id })
                 .or(Room.where.not(password_digest: nil))
                 .distinct
  end

  def show
    @room = Room.find(params[:id])

    # 参加者が存在するか確認し、現在のユーザーがルームに参加しているかをチェック
    if @room.password_digest.present? && !current_user.memberships.exists?(room: @room)
      if params[:password].blank? || !BCrypt::Password.new(@room.password_digest).is_password?(params[:password])
        redirect_to rooms_path, alert: 'パスワードが間違っています。' and return
      end
    end

    # 参加者のリストを取得、現在のユーザーが参加している場合のみを表示
    @participants = @room.memberships.includes(:user).where(user_id: current_user.id).distinct
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)

    if params[:room][:password].present?
      @room.password_digest = BCrypt::Password.create(params[:room][:password])
    end

    begin
      if @room.save
        current_user.memberships.create(room: @room)
        redirect_to rooms_path, notice: 'ルームが作成されました'
      else
        flash.now[:alert] = @room.errors.full_messages.join(", ")
        render :new, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotUnique
      flash.now[:alert] = "同じ名前のルームは作成できません。別の名前を使用してください。"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to room_path(@room), notice: 'ルームが更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @room.memberships.destroy_all
    @room.stocks.destroy_all
    @room.destroy
    redirect_to rooms_path, notice: 'ルームが削除されました。'
  end

  def search
    @rooms = Room.where("name LIKE ?", "%#{params[:query]}%")
  end

  def join
    room = Room.find_by(name: params[:room_name])

    if room && room.valid_password?(params[:password])
      unless current_user.memberships.exists?(room: room)
        current_user.memberships.create(room: room)
        redirect_to rooms_path, notice: 'ルームに参加しました。'
      else
        redirect_to rooms_path, alert: '既にこのルームに参加しています。'
      end
    else
      flash[:alert] = 'ルーム名またはパスワードが間違っています。'
      redirect_to rooms_path
    end
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :password) # passwordを許可する
  end

  def generate_image(product_name)
    "https://example.com/generated_images/#{product_name}.png"
  end
end
