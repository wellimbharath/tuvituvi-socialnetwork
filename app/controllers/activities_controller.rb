class ActivitiesController < ApplicationController
  def index
  	@user = current_user
  	@user_networks = @user.user_networks
    @friends = current_user.friends.unshift(current_user)
  	@activities = PublicActivity::Activity.all.order("created_at desc").where(owner_id: current_user.friend_ids, owner_type: "User")
  end
end
