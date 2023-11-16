class CommentsController < ApplicationController
  before_action :set_user
  before_action :set_post
  before_action :set_comment, only: [:show]

  def new
    @comment = @post.comments.new
  end

  def create
    @comment = current_user.comments.build(comment_params.merge(post: @post))
    if @comment.save
      redirect_to user_post_path(@post.author, @post)
    else
      render :new
    end
  end

  def edit
    @comment = @post.comments.find(params[:id])
  end

  def update
    @comment = @post.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to user_post_path(@post.author, @post), notice: 'Comment updated successfully'
    else
      render :edit
    end
  end

  def show
    @comments = @post.comments
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = @user.posts.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
