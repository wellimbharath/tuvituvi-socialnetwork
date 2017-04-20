class UpdateController < Wicked::WizardController
	before_action :authenticate_user!
	layout "update"
	include Wicked::Wizard
	
	steps :personal, :avatar, :background ,:bio
  
	def show
		
		@user = current_user
		render_wizard 

	end
		
	def update
		@user = current_user
		 if @user.update(user_params)
     	 sign_in @user, :bypass => true
		 end	
		render_wizard @user, :bypass => true
	end
  def create
    @following = current_user.followings.create!(:follow_id => params[:follow_id] )
    redirect_to :posts_path
  end
  
 def followings
 	root_path
 end

 def user_params
  params.require(:user).permit(:firstname, :dream,  :crop_x, :crop_y, :crop_w, :crop_h, :lastname, :dob, :bio, :interest, :background, :avatar, :role )
 end

end
