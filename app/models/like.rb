class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :update_post_likes_counter

  # Method to update the likes counter for a post
  def update_post_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end
