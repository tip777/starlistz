class ContactController < ApplicationController
  def index
    @contact = Contact.new
    render :action => 'index'
  end

  def thanks
    @contact = Contact.new(contact_params)
    if @contact.valid?
      ContactMailer.received_email(@contact, current_user).deliver
      redirect_to root_path, notice: "お問い合わせを送信しました"
    else
      render :action => 'index'
    end
  end
  
  def unsubscribe
    if current_user.nil?
      reject_page
    end
  end

  private

  def contact_params
    # submitしたデータのうち、Model作成に必要なものを
    # permitの引数に指定する
    params.require(:contact).permit(:name, :email, :title, :message)
  end


end
