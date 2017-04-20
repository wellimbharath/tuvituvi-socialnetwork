class PostController < ApplicationController
	def show
		 @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.friend_ids, owner_type: "User")
     @post = Post.find(params[:id]) 
     @user = User.find_by_username(params[:username])
	end
end
