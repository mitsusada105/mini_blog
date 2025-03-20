class CommentMailer < ApplicationMailer
  def new_comment
    @comment = params[:comment]
    @post = @comment.post
    @post_owner = @post.user
    mail(to: @post_owner.email, subject: 'あなたの投稿に新しいコメントが付きました')
  end
end

