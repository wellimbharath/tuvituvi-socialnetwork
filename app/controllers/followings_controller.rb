class FollowingsController < ApplicationController
	before_action :authenticate_user!

  def index
    @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.friend_ids, owner_type: "User")
    @users = User.all.where.not(id: current_user).joins(:user, :follow).first(5)
  end

	def create
    @following = current_user.followings.create!(:follow_id => params[:follow_id] )
    redirect_to :back, notice: "Started Following."
  end

  def destroy
    @following = current_user.followings.find(params[:id])
    @following.destroy
    redirect_to :back, notice: "Removed Following."
  end

end
