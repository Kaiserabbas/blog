class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
 
  validates :title, presence: true , length: { maximum: 250 }
  
  after_save :increment_user_post_counter

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def increment_user_post_counter
    author.increment!(:post_counter)
  end
end
