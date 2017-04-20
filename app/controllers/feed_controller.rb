class FeedController < ApplicationController
	def index
		@posts = Post.all
		 @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.friend_ids, owner_type: "User")
			@user = User.find_by_username(params[:username])
			@post = Post.new
		
    end

    def new
		@post = current_user.posts.build(post_params)
	end


	def show
     @post = Post.find(params[:id]) 
	end

  def edit
  end

  def upvote
  @post = Post.find(params[:id])
  @post.liked_by current_user
  if request.xhr?
     render json: { count: @post.get_likes.size, id: params[:id] }
  else
    redirect_to :back
  end
  end

  def downvote
  @post = Post.find(params[:id])
  @post.disliked_by current_user
  if request.xhr?
     render json: { count: @post.get_likes.size, id: params[:id] }
  else
    redirect_to :back
  end
end

def total
  self.get_upvotes.size - self.get_downvotes.size
end

	def create
    @post = current_user.posts.create(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to :back, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
        format.js
      else
        format.html { redirect_to :back, notice: 'Unable to create post' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content, :image, :audio, :video)
    end
end
