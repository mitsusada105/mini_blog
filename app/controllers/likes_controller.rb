class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @post.likes.find_or_create_by(user: current_user)
    render_likes_update
  end

  def destroy
    like = @post.likes.find_by(user: current_user)
    like&.destroy
    render_likes_update
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def render_likes_update
    render turbo_stream: [
      turbo_stream.replace("post_like_#{@post.id}", partial: "posts/post_content_like", locals: { post: @post }),
      turbo_stream.replace("post_liked_users", partial: "posts/liked_users", locals: { post: @post })
    ]
  end
end
