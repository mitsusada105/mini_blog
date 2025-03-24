class Post < ApplicationRecord
  PER_PAGE = 10

  belongs_to :user
  has_one_attached :image
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy

  validate :content_or_image_present
  validates :content, length: { maximum: 140 }

  private

  def content_or_image_present
    if content.blank? && !image.attached?
      errors.add(:base, "投稿内容か画像のどちらかを入力してください")
    end
  end
end
