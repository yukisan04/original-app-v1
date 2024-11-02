class ContactsController < ApplicationController
  def new
    @contact = Contact.new # Contactモデルを使用する場合
  end

  def create
    @contact = Contact.new(contact_params) # Contactモデルを使用する場合
    if @contact.save
      # お問い合わせが成功した場合の処理（例: メール送信）
      redirect_to root_path, notice: 'お問い合わせが送信されました。'
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :content, :phone_number) # 必要なパラメータを指定
  end
end
