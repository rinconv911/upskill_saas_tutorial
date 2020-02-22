class ContactsController < ApplicationController
  def new #This gets invoked whenever a user arrives at the form page
    @contact = Contact.new #Gets filled out by the form_for code in new.html.erb
  end
  
  def create #Code run when the user clicks 'Submit'
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:success] = "Message sent."
      redirect_to new_contact_path, notice: "Message sent." #Redirected to a blank form
    else 
      flash[:error] = @contact.errors.full_messages.join("<br />")
      redirect_to new_contact_path
    end
  end
  
  private #This is a security feature that whitelists and mass-assigns attributes
    def contact_params
      params.require(:contact).permit(:name, :email, :comments) 
    end 
end