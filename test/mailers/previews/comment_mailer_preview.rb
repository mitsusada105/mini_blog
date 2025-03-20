# Preview all emails at http://localhost:3000/rails/mailers/comment_mailer
class CommentMailerPreview < ActionMailer::Preview
  def new_comment
    comment = Comment.first || Comment.new(content: "サンプルコメント", user: User.first, post: Post.first)
    CommentMailer.with(comment: comment).new_comment
  end
end
