class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :update_post_comments_counter

  # Method to update the comments counter for a post
  def update_post_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
