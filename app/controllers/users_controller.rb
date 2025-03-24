class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])

    @posts = @user.posts.includes(:image_attachment)
    @posts = @posts.includes(:liked_users) if user_signed_in?
    @posts = @posts.order(created_at: :desc).page(params[:page]).per(Post::PER_PAGE)
  end
end
