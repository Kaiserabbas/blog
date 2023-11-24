class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_save :increment_post_likes_counter
  validates :user, uniqueness: { scope: :post }

  def increment_post_likes_counter
    post.increment!(:likes_counter)
  end
end
