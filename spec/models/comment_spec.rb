require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'is valid with a user and a post' do
    user = User.create(name: 'Tom', posts_counter: 0)
    post = Post.create(author: user, title: 'My Post')
    comment = Comment.new(user:, post:, text: 'Nice post!')
    expect(comment).to be_valid
  end

  it 'is not valid without a user' do
    post = Post.create(author: User.new, title: 'My Post', comments_counter: 0, likes_counter: 0)
    comment = Comment.new(user: nil, post:, text: 'Nice post!')
    comment.valid?
    expect(comment.errors[:user]).to include('must exist')
  end

  it 'is not valid without text' do
    user = User.create(name: 'Tom', posts_counter: 0)
    post = Post.create(author: user, title: 'My Post')
    comment = Comment.new(user:, post:, text: nil)
    comment.valid?
    expect(comment.errors[:text]).to include("can't be blank")
  end

  it 'updates the comments counter for a post' do
    user = User.create(name: 'Tom', posts_counter: 1)
    post = Post.create(author: user, title: 'My Post')
    comment = Comment.create(user:, post:, text: 'Nice post!')

    comment.increment_post_comments_counter

    post.reload
    expect(post.comments_counter).to eq(2)
  end
end
