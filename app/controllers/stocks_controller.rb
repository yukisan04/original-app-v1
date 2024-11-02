class StocksController < ApplicationController
  before_action :set_room
  before_action :set_stock, only: [:edit, :update, :destroy]

  def index
    @stocks = Stock.all
  end

  def show
    @stock = @room.stocks.find(params[:id]) # 特定の在庫を取得
  end

  def new
    @stock = @room.stocks.build # 新しい在庫のインスタンスを作成
  end

  def create
    @stock = @room.stocks.new(stock_params)

    # 画像が添付されていない場合はデフォルト画像を表示
    unless @stock.image.attached?
      @stock.image.attach(io: File.open(Rails.root.join('app/assets/images/default_image.png')), filename: 'default_image.png', content_type: 'image/png')
    end

    if @stock.save
      redirect_to room_path(@room), notice: '在庫が正常に追加されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @room = Room.find(params[:room_id])
    @stock = Stock.find(params[:id])
    @participants = @room.memberships.includes(:user) # 参加者を取得
  end

  def update
    if @stock.update(stock_params)
      unless @stock.image.attached?
        @stock.image.attach(io: File.open(Rails.root.join('app/assets/images/default_image.png')), filename: 'default_image.png', content_type: 'image/png')
      end
      redirect_to room_path(@room), notice: '在庫が更新されました。'
    else
      Rails.logger.error "Failed to update stock: #{@stock.errors.full_messages.join(', ')}"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @stock.destroy  # 在庫を削除
    redirect_to room_path(@room), notice: '在庫が削除されました。'
  end

  def increment
    @stock = Stock.find(params[:id])

    # ストックの数量を更新する
    change = params[:change].to_i
    @stock.quantity += change
    if @stock.save
      render json: { success: true }
    else
      render json: { success: false }, status: :unprocessable_entity
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_stock
    @stock = @room.stocks.find(params[:id])
  end

  def stock_params
    params.require(:stock).permit(:product_name, :quantity, :image, :stock_status) # ここでimageを許可
  end
end
