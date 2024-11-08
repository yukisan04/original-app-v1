class ContactsController < ApplicationController
  before_action :authenticate_user! # ログイン確認
  before_action :require_admin_or_owner, only: [:index] # 権限チェック

  def new
    @contact = Contact.new
  end

  def create
    @contact = current_user.contacts.new(contact_params)
    if @contact.save
      redirect_back(fallback_location: root_path, notice: 'お問い合わせが送信されました。')
    else
      render :new
    end
  end

  def index
    @contacts = Contact.order(created_at: :desc).page(params[:page]).per(10) # 1ページあたり10件表示
  end

  def create_reply
    @contact = Contact.find(params[:contact_id])
    @reply = @contact.replies.build(reply_params)
    if @reply.save
      redirect_to contacts_path, notice: '返信が送信されました。'
    else
      render :index
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :content)
  end

  def require_admin_or_owner
    unless current_user.admin? || current_user == @contact.user
      redirect_to root_path, alert: "閲覧権限がありません。"
    end
  end

  def reply_params
    params.require(:reply).permit(:content)
  end
end
