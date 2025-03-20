class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy

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
end