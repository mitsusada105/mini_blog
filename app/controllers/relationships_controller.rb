class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:following_id])
    current_user.follow(user)
    redirect_to user_path(user), notice: "#{user.username} をフォローしました。"
  end

  def destroy
    user = User.find(params[:id])
    current_user.unfollow(user)
    redirect_to user_path(user), notice: "#{user.username} のフォローを解除しました。"
  end
end
