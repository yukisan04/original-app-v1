class RepliesController < ApplicationController
  before_action :set_contact

  def create
    @reply = @contact.replies.build(reply_params)
    @reply.user = current_user

    if @reply.save
      redirect_to @contact, notice: '返信が送信されました。'
    else
      redirect_to @contact, alert: '返信の送信に失敗しました。'
    end
  end

  private

  def set_contact
    @contact = Contact.find(params[:contact_id])  # 親のcontactを設定
  end

  def reply_params
    params.require(:reply).permit(:content)  # 返信内容を許可
  end
end