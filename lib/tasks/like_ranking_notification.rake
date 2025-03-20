namespace :notify do
  desc "前日のいいね数ランキングメール通知"
  task like_ranking: :environment do
    yesterday = Date.yesterday
    top_posts = Post.joins(:likes)
                    .where(created_at: yesterday.all_day)
                    .group("posts.id")
                    .order("COUNT(likes.id) DESC")
                    .limit(10)
    NotificationMailer.like_ranking_notification(top_posts).deliver_now
    puts "メール通知を送信しました。"
  end
end
