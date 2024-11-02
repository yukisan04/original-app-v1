class ItemsController < ApplicationController
  def index
    if params[:sort] == 'newest'
      @items = Item.order(created_at: :desc) # 新しい順
    elsif params[:sort] == 'oldest'
      @items = Item.order(created_at: :asc) # 古い順
    else
      @items = Item.order(created_at: :asc) # デフォルトは古い順
    end
  end
end