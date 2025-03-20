class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @post = Post.new
    @all_posts = Post.order(created_at: :desc) # 全体タイムライン
    if user_signed_in?
      @followed_posts = Post.where(user: current_user.following).or(Post.where(user: current_user)).order(created_at: :desc)
    else
      @followed_posts = Post.none
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "投稿しました！"
    else
      @all_posts = Post.order(created_at: :desc)
      @followed_posts = Post.where(user: current_user.following).or(Post.where(user: current_user)).order(created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end


