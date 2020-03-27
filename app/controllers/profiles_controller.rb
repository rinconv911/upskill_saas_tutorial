class ProfilesController  < ApplicationController
  before_action :authenticate_user!
  before_action :only_current_user
  
  # When user makes a GET request to /users/:user_id/profile/new
  def new
    # Render a blank profile details form
  @profile = Profile.new
  end
  
  # When user makes a POST request to users/:user_id/profile
  def create
    # Ensure that we hvae the user who is filling out the form
    @user = User.find(params[:user_id])
    # Create profile linked to this specific user
    @profile = @user.build_profile(profile_params)
    if @profile.save
      flash[:success] = "Profile updated!"
      redirect_to user_path(id: params[:user_id])
    else
      render action: :new
    end
  end
  
  # GET request to /users/:user_id/profile/edit
  def edit
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end
  
  # PUT request to /users/:user_id/profile
  def update
    # Retrieve user from DB. Params come from form action (inspect it), NOT URL
    # Retrieve that user's profile
    @user = User.find(params[:user_id])
    @profile = @user.profile
    # Mass assign edited profile attributes and save (AKA update)
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile updated"
      # Redirect user to their profile page (params come from FORM ACTION)
      redirect_to user_path(id: params[:user_id])
    else 
      render action: :edit
    end
  end
  
  private
    # To collect data from form, we need to use strong parameters
    # and whitelist the form fields (so only these can be accepted into our db)
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end
    
    def only_current_user
      @user = User.find(params[:user_id])
      redirect_to(root_path) unless @user == current_user
    end
end