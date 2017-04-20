class LearnsController < ApplicationController
	def index
		@activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.friend_ids, owner_type: "User")
		render :layout => true
		@user_networks = @user.user_networks
	end
end
