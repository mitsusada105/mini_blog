if defined?(Bullet) && Rails.env.development?
  Bullet.enable = true
  Bullet.bullet_logger = true
  Bullet.add_safelist type: :unused_eager_loading, class_name: "Post", association: :likes
end
