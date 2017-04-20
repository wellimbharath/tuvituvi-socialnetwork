class ProfileController < ApplicationController
	def show 
		@user = User.find_by_username(params[:username])
		if user_signed_in?
		 @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.friend_ids, owner_type: "User")
		end
		if @user
			@user_networks = @user.user_networks
			@posts = @user.posts.all.includes(:user).order("created_at DESC").page(params[:page]).per_page(5)
		else
      		render file: 'public/404', status: 404, formats: [:html]
    	end
	end
end

