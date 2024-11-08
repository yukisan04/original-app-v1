class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact, only: [:show, :edit, :update, :destroy, :resolve, :reopen]

  def index
    @contacts = Contact.order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @contact = Contact.new
    @contact.email = current_user.email
  end

  def show
    @reply = @contact.replies.build
  end

  def create
    @contact = current_user.contacts.new(contact_params)

    if @contact.save
      redirect_to contacts_path, notice: 'お問い合わせが送信されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def create_reply
    @reply = @contact.replies.build(reply_params)
    @reply.user = current_user
    if @reply.save
      redirect_to contact_path(@contact), notice: '返信が送信されました。'
    else
      render :show, status: :unprocessable_entity
    end
  end

  def resolve
    @contact.closed!
    redirect_to contact_path(@contact), notice: 'お問い合わせが解決済みとなりました。'
  end

  def reopen
    if current_user.admin?
      @contact.update(status: :open)
      redirect_to @contact, notice: '問い合わせが再度オープンにされました。'
    else
      redirect_to contacts_path, alert: '権限がありません。'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :content)
  end

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def reply_params
    params.require(:reply).permit(:content)
  end
end
