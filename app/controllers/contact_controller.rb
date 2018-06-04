class ContactController < ApplicationController
  def index
    @contact = Contact.new
    render :action => 'index'
  end
  
  def confirm
    @contact = Contact.new(contact_params)
    if @contact.valid?
      render :action => 'confirm'
    else
      render :action => 'index'
    end
    # respond_to do |format|
    #   if @inquiry.save
    #     InquiryMailer.inquiry_email(@inquiry).deliver
    #     format.html { redirect_to @inquiry, notice: 'Inquiry was successfully created.' }
    #     format.json { render :show, status: :created, location: @inquiry }
    #   else
    #   end
    # end
  end
  
  def thanks
    @contact = Contact.new(contact_params)
    if @contact.valid?
      ContactMailer.received_email(@contact).deliver
    else
      render :action => 'index'
    end
   
    render :action => 'thanks'
  end
  
  private

  def contact_params
    # submitしたデータのうち、Model作成に必要なものを
    # permitの引数に指定する
    params.require(:contact).permit(:name, :email, :message)
  end
  
  
end
