class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash[:notice] = 'Thank you for your message. We will contact you very soon!'
      @contact = Contact.new
      render :new
    else
      flash[:error] = 'Cannot send message. Please contact support@groupmates.uk and blame the developers!'
      render :new
    end
  end
end