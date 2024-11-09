class RepliesController < ApplicationController
  before_action :set_contact
  before_action :set_reply, only: [:show, :edit, :update, :destroy]

  def create
    @reply = @contact.replies.build(reply_params)
    @reply.user = current_user

    if @reply.save
      redirect_to @contact, notice: '返信が送信されました。'
    else
      redirect_to @contact, alert: '返信の送信に失敗しました。'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @reply.update(reply_params)
      redirect_to @contact, notice: '返信が更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @reply.destroy
    redirect_to @contact, notice: '返信が削除されました。'
  end

  private

  def set_contact
    @contact = Contact.find(params[:contact_id])  # 親のcontactを設定
  end

  def set_reply
    @reply = @contact.replies.find_by(id: params[:id])  # 該当の返信を設定
    redirect_to @contact, alert: '返信が見つかりません。' if @reply.nil?  # 返信が見つからない場合の処理
  end

  def reply_params
    params.require(:reply).permit(:content)  # 返信内容を許可
  end
end
