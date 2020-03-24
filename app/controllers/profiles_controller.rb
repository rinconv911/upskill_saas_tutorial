class ProfilesController  < ApplicationController
  # When user makes a GET request to /users/:user_id/profile/new
  def new
    # Render a blank profile details form
  @profile = Profile.new
  end
  
  # When user makes a POST request to users/:user_id/Profile
  def create
    # Ensure that we hvae the user who is filling out the form
    @user = User.find(params[:user_id])
    # Create profile linked to this specific user
    @profile = @user.build_profile(profile_params)
    if @profile.save
      flash[:success] = "Profile updated!"
      redirect_to root_path
    else
      render action: :new
    end
  end
  
  private
  # To collect data from form, we need to use strong parameters
  # and whitelist the form fields (so only these can be accepted into our db)
  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description)
  end
end