class NotificationMailer < ApplicationMailer
  def like_ranking_notification(top_posts)
    @posts = top_posts
    mail(to: "admin@example.com", subject: "前日のいいね数ランキング")
  end
end
