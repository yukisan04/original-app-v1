class UpdatersController < ApplicationController
  before_action :authenticate_admin!, only: [:new]  # 管理者のみアクセス可能

  def index
    @updaters = Updater.all.order(created_at: :desc)
  end

  def new
    @updater = Updater.new
  end

  def create
    @updater = Updater.new(updater_params)
    if @updater.save
      redirect_to updaters_path, notice: '更新情報が追加されました'
    else
      render :new
    end
  end

  def admin?
    self.admin
  end

  private

  def updater_params
    params.require(:updater).permit(:title, :content)
  end

  def authenticate_admin!
    redirect_to root_path, alert: '管理者権限が必要です' unless current_user&.admin?
  end
end
