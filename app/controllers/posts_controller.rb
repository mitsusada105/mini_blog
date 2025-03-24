class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @post = Post.new
    if user_signed_in?
      @all_posts = Post.includes(:user, :likes, :liked_users, :image_attachment).order(created_at: :desc).page(params[:page]).per(10)
    else
      @all_posts = Post.includes(:user, :image_attachment).order(created_at: :desc).page(params[:page]).per(10)
    end
  end  

  def following
    @followed_posts = Post.includes(:user, :likes, :liked_users, :image_attachment).where(user: current_user.following).order(created_at: :desc).page(params[:page]).per(10)
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "投稿しました！"
    else
      @all_posts = Post.includes(:user, :likes, :liked_users, :image_attachment).order(created_at: :desc).page(params[:page]).per(10)
      render :index, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user).order(created_at: :asc)
  end

  private

  def post_params
    params.require(:post).permit(:content, :image)
  end
end


