class PasswordResetsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :index] # 認証をスキップ

  def index
    # パスワードリセットリクエスト用のインデックスページ
  end

  def new
    @contact = Contact.new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      @user.send_password_reset # パスワードリセットのメール送信
      redirect_to root_path, notice: "パスワードリセットのメールを送信しました。"
    else
      flash.now[:alert] = "メールアドレスが見つかりませんでした。"
      render :new
    end
  end

  # その他のアクションも必要に応じて実装
end
