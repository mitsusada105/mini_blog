# config/initializers/bullet.rb

Bullet.add_safelist type: :unused_eager_loading, class_name: 'Post', association: :likes
