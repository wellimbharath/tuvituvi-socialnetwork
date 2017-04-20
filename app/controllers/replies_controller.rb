class RepliesController < ApplicationController
	before_action :set_comment

def create  
   @reply = @comment.replies.build(reply_params)
  @reply.user_id = current_user.id

  if @reply.save
    flash[:success] = "You replyed the hell out of that post!"
    redirect_to :back
  else
    flash[:alert] = "Check the reply form, something went horribly wrong."
    render root_path
  end
end
def destroy  
  @reply = @comment.replies.find(params[:id])

  @comment.destroy
  flash[:success] = "Reply deleted :("
  redirect_to root_path
end  
private

def reply_params  
  params.require(:reply).permit(:content)
end

def set_comment  
  @comment = Comment.find(params[:comment_id])
end  
end
