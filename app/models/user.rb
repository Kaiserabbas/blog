class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  attr_accessor :unconfirmed_email
  
  validates :email, presence: true
  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  attribute :posts_counter, :integer, default: 0
  
    def admin?
      role == 'admin'
    end

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
