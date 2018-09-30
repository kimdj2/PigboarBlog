class ContactController < ApplicationController
  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new contact_params
    respond_to do |format|
      if @contact.valid?
        ContactMailer.contact_me(@contact).deliver
        format.js
      else
        format.js
      end
    end
  end
  
  private
  
  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end

end
