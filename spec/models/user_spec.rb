# spec/models/user_spec.rb
require 'rails_helper'
require 'faker'  # Faker を利用するための require

RSpec.describe User, type: :model do
  # --- アソシエーションのテスト ---
  describe 'アソシエーション' do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:liked_posts).through(:likes).source(:post) }

    it { is_expected.to have_many(:active_relationships)
                        .class_name('Relationship')
                        .with_foreign_key('follower_id')
                        .dependent(:destroy) }
    it { is_expected.to have_many(:following)
                        .through(:active_relationships)
                        .source(:following) }

    it { is_expected.to have_many(:passive_relationships)
                        .class_name('Relationship')
                        .with_foreign_key('following_id')
                        .dependent(:destroy) }
    it { is_expected.to have_many(:followers)
                        .through(:passive_relationships)
                        .source(:follower) }
  end

  # --- バリデーションのテスト ---
  describe 'バリデーション' do
    # uniqueness のテストのために、あらかじめユーザーを作成しておく
    subject { create(:user) }

    # username のテスト（Faker を使ってランダムなアルファベットを生成）
    it 'username が存在し、重複せず、20文字以内、アルファベットのみであること' do
      valid_username = Faker::Alphanumeric.alpha(number: 8)
      user = build(:user, username: valid_username)
      expect(user).to be_valid

      # 存在しない場合のテスト
      user.username = nil
      expect(user).not_to be_valid
      expect(user.errors[:username]).to include("ユーザー名を入力してください")

      # アルファベット以外の文字が含まれている場合
      user.username = "あいうえお"
      expect(user).not_to be_valid
      expect(user.errors[:username]).to include("ユーザー名はアルファベット20文字以内で入力してください")
    end

    # email のテスト（Faker を利用して正しい形式のメールアドレスを生成）
    it 'email が存在し、重複せず、正しい形式であること' do
      valid_email = Faker::Internet.email
      user = build(:user, email: valid_email)
      expect(user).to be_valid

      # email が空の場合
      user.email = nil
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("メールアドレスを入力してください")

      # 不正なメールアドレス形式の場合
      user.email = "invalid_email"
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("正しいメールアドレス形式で入力してください")
    end

    # profile のテスト（Faker で200文字以内の文字列を生成）
    it 'profile は200文字以内であること' do
      user = build(:user, profile: Faker::Lorem.characters(number: 200))
      expect(user).to be_valid

      user.profile = Faker::Lorem.characters(number: 201)
      expect(user).not_to be_valid
    end

    # blog_url のテスト（Faker で正しい URL を生成）
    it 'blog_url は正しいURL形式であること（空の場合はOK）' do
      user = build(:user, blog_url: Faker::Internet.url)
      expect(user).to be_valid

      user.blog_url = "invalid_url"
      expect(user).not_to be_valid
      expect(user.errors[:blog_url]).to include("正しいURL形式で入力してください")

      # 空文字の場合はバリデーションが通ること
      user.blog_url = ""
      expect(user).to be_valid
    end
  end

  # --- Devise のオーバーライドメソッドのテスト ---
  describe 'Devise のオーバーライド' do
    let(:user) { build(:user) }

    it '#email_required? は false を返すこと' do
      expect(user.email_required?).to be_falsey
    end

    it '#email_changed? は false を返すこと' do
      expect(user.email_changed?).to be_falsey
    end
  end

  # --- フォロー機能のテスト ---
  describe 'フォロー機能' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    describe '#follow' do
      it '他のユーザーをフォローできること' do
        user.follow(other_user)
        expect(user.following?(other_user)).to be_truthy
      end

      it '自分自身をフォローしようとしないこと' do
        user.follow(user)
        expect(user.following?(user)).to be_falsey
      end
    end

    describe '#unfollow' do
      it 'フォロー解除ができること' do
        user.follow(other_user)
        user.unfollow(other_user)
        expect(user.following?(other_user)).to be_falsey
      end
    end

    describe '#following?' do
      it 'フォローしていない場合は false を返すこと' do
        expect(user.following?(other_user)).to be_falsey
      end
    end
  end
end
