  class CommentsController < ApplicationController
    load_and_authorize_resource
    before_action :set_post
    def new
      @comment = Comment.new
    end

    def create
      @comment = current_user.comments.build(comment_params.merge(post: @post))
      if @comment.save
        @post.comments_counter += 1
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

    def destroy
      @comment = Comment.find(params[:id])
      @post = @comment.post

      if @comment.destroy
        @post.update(comments_counter: @post.comments.count)
        flash[:notice] = 'Comment deleted successfully.'
      else
        flash[:error] = 'Failed to delete comment.'
      end

      redirect_to user_post_path(@post.author, @post)
    end
    

    private

    def set_post
      @post = Post.find(params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:text)
    end
  end
