class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def update_user_posts_counter
    update(posts_counter: posts.count)
  end
end
