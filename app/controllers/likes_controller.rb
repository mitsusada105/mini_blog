class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)

    if @like.save
      redirect_to root_path, notice: '投稿にいいねしました'
    else
      redirect_to root_path, alert: 'いいねできませんでした'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_by(user: current_user)

    if @like
      @like.destroy
      redirect_to root_path, notice: 'いいねを解除しました'
    else
      redirect_to root_path, alert: 'いいね解除に失敗しました'
    end
  end
end
