class CreatesController < ApplicationController
	def index
	end

	def create
    @following = current_user.followings.create!(:follow_id => params[:follow_id] )
    redirect_to  root_path , notice: "Started Following."
  end
  
  def destroy
    @following = current_user.followings.find(params[:id])
    @following.destroy
    redirect_to :back, notice: "Removed Following."
    end
end
