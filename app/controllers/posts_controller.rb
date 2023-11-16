class PostsController < ApplicationController
  before_action :set_user
  before_action :set_post, only: [:show]
  before_action :initialize_like

  def new
    @post = @user.posts.new
  end
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to user_posts_path(current_user), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: params[:user_id])
  end

  def show
    @user = User.find_by_id(params[:user_id])
    @post = Post.find_by_id(params[:id])
    @like = current_user.likes.find_by(post: @post) || Like.new
    @comments = @post.comments
  end

  private

  def set_user
    @user = current_user
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def initialize_like
    @like = Like.new
  end
  def post_params
    params.require(:post).permit(:title, :text)
  end
end
