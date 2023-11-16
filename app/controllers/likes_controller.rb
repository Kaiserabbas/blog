class LikesController < ApplicationController
  before_action :find_post, only: %i[new create]
  before_action :set_user
  before_action :set_post
  before_action :set_like, only: [:destroy]

  def new
    @like = @post.likes.new
  end

  def create
    @like = @post.likes.new(user: current_user)

    if @like.save
      redirect_to user_post_path(@post.author, @post), notice: 'Post liked!'
    else
      render :new
    end
  end

  def destroy
    @like.destroy
    redirect_to user_post_path(@post.author, @post)
  end

  private

  def set_like
    @like = @post.likes.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = @user.posts.find(params[:post_id])
  end

  def find_post
    @post = Post.find(params[:post_id])
  end
end
