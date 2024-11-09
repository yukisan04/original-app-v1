class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact, only: [:show, :edit, :update, :destroy, :resolve, :reopen]
  before_action :set_reply, only: [:edit, :update, :destroy]

  def index
    @contacts = Contact.order(created_at: :desc).page(params[:page]).per(10)
  end

  def edit

  end

  def new
    @contact = Contact.new
    @contact.email = current_user.email
  end

  def show
    @reply = @contact.replies.build
  end

  def create
    @contact = current_user.contacts.build(contact_params)

    if @contact.save
      redirect_to @contact, notice: 'お問い合わせが送信されました。'
    else
      render :new, alert: 'お問い合わせの送信に失敗しました。'
    end
  end

  def update
    if @reply.update(reply_params)
      redirect_to @contact, notice: '返信が更新されました。'
    else
      render 'contacts/show', alert: '返信の更新に失敗しました。'
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
    if @contact.update(status: :closed)
      respond_to do |format|
        format.html { redirect_to @contact, notice: 'お問い合わせは解決済みとしてマークされました。' }
        format.turbo_stream
      end
    else
      redirect_to @contact, alert: '解決済みとしてマークする際にエラーが発生しました。'
    end
  end

  def reopen
    if @contact.update(status: :reopened)
      redirect_to @contact, notice: 'お問い合わせは再開されました。'
    else
      redirect_to @contact, alert: '再開に失敗しました。'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :content)
  end

  def set_contact
    @contact = Contact.find_by(id: params[:id])
    redirect_to root_path, alert: "Contact not found" if @contact.nil?
  end

  def set_reply
    @reply = @contact.replies.find_by(id: params[:id])
    redirect_to contact_path(@contact), alert: "Reply not found" if @reply.nil?
  end

  def reply_params
    params.require(:reply).permit(:content)
  end
end
