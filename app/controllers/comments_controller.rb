class CommentsController < ApplicationController
  before_action :authenticate_user!  # ユーザー登録が必要な場合

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      # 投稿者へメール通知（後述のメール送信設定）
      # CommentMailer.with(comment: @comment).new_comment.deliver_later
      redirect_to @post, notice: 'コメントを追加しました'
    else
      redirect_to @post, alert: 'コメントの追加に失敗しました'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
