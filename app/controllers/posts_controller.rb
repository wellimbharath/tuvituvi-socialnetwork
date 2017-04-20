class PostsController < ApplicationController

   before_action :set_post, only: [:show, :edit, :update, :destroy]
   before_filter :authenticate_user!
   respond_to :html, :js

  def index
    @user = User.find_by_username(params[:username])
    @friends = current_user.friends.unshift(current_user)
    @blocked = current_user.blockd
    @users = User.all.where.not(id: current_user.id)
    @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.friend_ids, owner_type: "User")
    @posts = Post.all.where(user_id: @friends).where.not(user_id: @blocked).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    @post = Post.new
    @user_networks = current_user.user_networks
  end

  def post
  end

  def followings
    @user = current_user
  end

  def new
    @post = current_user.posts.build
  end


  def show
     @post = Post.find(params[:id])
  end

  def edit
  end

  def upvote
  @post = Post.find(params[:id])
  @post.upvote_by current_user
  @post.votes_for.size

  redirect_to :back
  end

def downvote
  @post = Post.find(params[:id])
  @post.downvote_by current_user
  @post.votes_for.size
  @post.downvote_from current_user
  redirect_to :back
end

def total
  self.get_upvotes.size - self.get_downvotes.size
end

  def create
    @post = current_user.posts.build(post_params)
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

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to posts_path, notice: 'Post was successfully updated.' }
        format.json { render :index, status: :ok, location: @posts }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
      format.js
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
