class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_all_posts, only: [:index, :create]

  def index
    @post = Post.new
  end  

  def following
    @followed_posts = build_post_scope(Post.where(user: current_user.following))
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "投稿しました！"
    else
      flash.now[:alert] = @post.errors.full_messages.join("、")
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

  def set_all_posts
    @all_posts = build_post_scope
  end

  def build_post_scope(scope = Post.all)
    scope = scope.includes(:user, :image_attachment)
    scope = scope.includes(:liked_users) if user_signed_in?
    scope.order(created_at: :desc).page(params[:page]).per(Post::PER_PAGE)
  end  

end


