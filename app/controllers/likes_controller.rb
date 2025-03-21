class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("post_like_#{@post.id}", partial: "posts/post_content", locals: { post: @post })
      end
      format.html { redirect_to @post }
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
