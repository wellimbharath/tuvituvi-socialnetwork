class FollowsController < ApplicationController
	def index 
		 @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.friend_ids, owner_type: "User")
	  @users = User.includes(:follow).first(3)
	  @user = User.find_by_username(params[:username])
	end
end
