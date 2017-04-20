class ChatsController < ApplicationController
	def index
		@friends = current_user.friends
		@users = User.where(id: @friends).where.not("id = ?",current_user.id).order("created_at DESC")
		@user_networks = current_user.user_networks
		@conversations = Conversation.involving(current_user).order("created_at DESC")
	end
end
