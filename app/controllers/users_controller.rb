class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:likes, :liked_users, :image_attachment).order(created_at: :desc).page(params[:page]).per(10)
  end
end
