class ContactsController < ApplicationController
  def new #This gets invoked whenever a user arrives at the form page
    @contact = Contact.new #Gets filled out by the form_for code in new.html.erb
  end
  
  def create #Code runs when the user clicks 'Submit'
    @contact = Contact.new(contact_params)
    if @contact.save
      
      #Lifting the values of the form fields and use them in the action
      name = params[:contact][:name]
      email  = params[:contact][:email]
      body = params[:contact][:comments]
      ContactMailer.contact_email(name, email, body).deliver
      
      flash[:success]= "Message sent."
      redirect_to new_contact_path #Redirected to a blank form
    else 
      #Make  sure that the equal is right beside the square bracket
      flash[:danger]= @contact.errors.full_messages.join(", ")
      redirect_to new_contact_path
    end
  end
  
  private #This is a security feature that whitelists and mass-assigns attributes
    def contact_params
      params.require(:contact).permit(:name, :email, :comments) 
    end 
end