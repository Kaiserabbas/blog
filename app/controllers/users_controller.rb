class UsersController < ApplicationController
  def index
    @users = User.includes(:posts).paginate(page: params[:page], per_page: 6)
  end

  def show
    @user = User.includes(posts: :author).find(params[:id])
    @posts = @user.posts
  end
end
