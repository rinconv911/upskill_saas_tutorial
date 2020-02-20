class ContactsController < ApplicationController
  def new
    @contact = Contact.new #Gets filled out by the form_for code in new.html.erb
  end
  
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to new_contact_path, notice: "Message sent." #Redirected to a blank form
    else 
      redirect_to new_contact_path, notice: "An error occurred."
    end
  end
  
  private
    def contact_params
      params.require(:contact).permit(:name, :email, :comments)
    end 
end