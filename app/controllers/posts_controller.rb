class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @post = Post.new
    @all_posts = Post.includes(:likes).order(created_at: :desc).page(params[:page]).per(10) # 全体タイムライン
    if user_signed_in?
      @followed_posts = Post.includes(:likes).where(user: current_user.following).order(created_at: :desc).page(params[:page]).per(10)
    else
      @followed_posts = Post.none
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "投稿しました！"
    else
      @all_posts = Post.includes(:likes).order(created_at: :desc).page(params[:page]).per(10)
      @followed_posts = Post.includes(:likes).where(user: current_user.following).order(created_at: :desc).page(params[:page]).per(10)
      render :index, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.includes(:liked_users).find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:content, :image)
  end
end


