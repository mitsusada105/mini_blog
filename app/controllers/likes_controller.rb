class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_or_create_by(user: current_user)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("post_like_#{@post.id}", partial: "posts/post_content_like", locals: { post: @post })
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_by(user: current_user)

    if @like
      @like.destroy
    end

    render turbo_stream: turbo_stream.replace("post_like_#{@post.id}", partial: "posts/post_content_like", locals: { post: @post })
  end
end
