class UserNetworksController < ApplicationController

  before_filter :authenticate_user!

	def index
		@activities = PublicActivity::Activity.all.order("created_at desc").where(owner_id: current_user.friend_ids, owner_type: "User")
		@user_networks = current_user.user_networks
	end

	def update

		@user_network = current_user.user_networks.find(params[:id])

		if @user_network.accept!

			respond_to do |format|
				format.html {redirect_to user_networks_path}
				format.js
			end

		end

	end

	def block

		@user_network = current_user.user_networks.find(params[:id])

		if @user_network.block!

			respond_to do |format|
				format.html {redirect_to user_networks_path}
				format.js {render "block"}

			end

		end
	end

	def new

		if params[:friend_id]
			@friend = User.find(params[:friend_id])
			@user_network = current_user.user_networks.new(friend: @friend)

		else

			flash[:error] = "Friend required"

		end

	rescue ActiveRecord::RecordNotFound

		render file: 'public/404', status: :not_found

	end

	def create
		if params[:user_network] && params[:user_network].has_key?(:friend_id)
			@friend = User.find(params[:user_network][:friend_id])
			@user_network = UserNetwork.request(current_user, @friend)
				respond_to do |format|
					if @user_network.new_record?
						format.html do
							flash[:error] = "There was a problem creating that friend request."
							redirect_to :back
						end
						format.json {render json: @user_network.to_json}
					else
						format.html do
							flash[:success] = "Friend request sent"
							redirect_to :back
						end
						format.json {render json: @user_network.to_json}
					end
				end
	   	else
			flash[:error] = "Friend required"
			redirect_to root_path
		end
	end

	def edit
		@user_network = current_user.user_networks.find(params[:id])
		@friend = @user_network.friend
	end

	def destroy
	   @user_network = current_user.user_networks.find(params[:id])

		if @user_network.destroy

			respond_to do |format|
				format.json {render json: @user_network.to_json}
				format.html {redirect_to user_networks_path, notice: "You have deleted a study partner!"}
			end

		end

	end
end
