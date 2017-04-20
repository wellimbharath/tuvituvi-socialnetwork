class UsersController < ApplicationController
	before_action :authenticate_user!

def index
		@activities = PublicActivity::Activity.all.order("created_at desc").where(owner_id: current_user.friend_ids, owner_type: "User")	
	#@users = User.all.search(params)	
    @users = User.where(id: @friends).where.not("id = ?",current_user.id).order("created_at DESC").search(params)	
	@friends = current_user.friends
	@user_networks = current_user.user_networks
	@conversations = Conversation.involving(current_user).order("created_at DESC")
	@activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.friend_ids, owner_type: "User")
end

def create 
 @user = User.new(user_parms)
 if @user.save
 	redirect_to update_path
 else 
 	redirect_to update_path
 end
end

def incomplete_dreams
  @incomplete_dreams = Dreams.where(complete: false)
end

protected

def user_params
  params.require(:user).permit(:firstname,:dream, :lastname, :dob, :crop_x, :crop_y, :crop_w, :crop_h,:bio, :interest, :background, :avatar, :role)
end

end
