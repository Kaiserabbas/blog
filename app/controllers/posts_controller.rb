class PostsController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_post, only: [:show]
  before_action :initialize_like

  def new
    @user = current_user
    @post = @user.posts.build
  end

  def create
    @user = current_user
    @post = @user.posts.build(post_params)

    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments).paginate(page: params[:page], per_page: 6)
  end

  def show
    @user = User.find_by_id(params[:user_id])
    @post = Post.find_by_id(params[:id])

    if @post
      @like = @post.likes
      @comments = @post.comments
    else
      flash[:error] = 'Post not found'
      # Redirect or handle the scenario where the post isn't found
      redirect_to user_posts_path(@user)
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])

    if @post
      @user = @post.author

      if @post.destroy
        @user.posts_counter -= 1
        @user.save
        flash[:notice] = 'Post deleted successfully.'
      else
        flash[:error] = 'Failed to delete post.'
      end
    else
      flash[:error] = 'Post not found.'
    end

    redirect_to user_posts_path(@user)
  end

  private

  def set_post
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Post not found'
    redirect_to user_posts_path(@user)
  end

  def initialize_like
    @like = Like.new
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
