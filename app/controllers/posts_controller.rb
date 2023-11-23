class PostsController < ApplicationController
  before_action :set_post, only: [:show]
  before_action :initialize_like

  def new
    @user = User.find(params[:user_id])
    @post = Post.build
  end

  def create
    @user = User.find(params[:user_id])
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
    @like = @post.likes
    @comments = @post.comments
  end

  private

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
