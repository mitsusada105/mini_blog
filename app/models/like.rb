class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true
  validates :user_id, uniqueness: { scope: :post_id } # 1人1投稿1いいね制限
end
