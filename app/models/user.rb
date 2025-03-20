class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  # フォロー機能の関連付け
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :following

  has_many :passive_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  validates :username, presence: true, uniqueness: true,
            length: { maximum: 20 },
            format: { with: /\A[a-zA-Z]+\z/, message: "はアルファベットのみ使用できます" }
  
  validates :profile, length: { maximum: 200 }, allow_blank: true
  validates :blog_url, format: { with: URI::DEFAULT_PARSER.make_regexp, message: "は正しいURL形式で入力してください" }, allow_blank: true

  # Devise のデフォルトの email 必須設定をオーバーライド
  def email_required?
    false
  end

  def email_changed?
    false
  end

  # フォローする
  def follow(user)
    following << user unless self == user || following?(user)
  end

  # フォロー解除
  def unfollow(user)
    following.delete(user)
  end

  # フォローしているか確認
  def following?(user)
    following.include?(user)
  end
end