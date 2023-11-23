require 'rails_helper'

RSpec.feature 'User show page' do
  let!(:user1) { User.create(name: 'Qaisar', bio: 'A student', photo: 'https://avatars.githubusercontent.com/u/123939543?v=4') }
  let!(:post1) { Post.create(author: user1, title: 'Post 01', text: 'Hello World!') }
  let!(:post2) { Post.create(author: user1, title: 'Post 02', text: 'Hello World!') }
  let!(:post3) { Post.create(author: user1, title: 'Post 03', text: 'Hello World!') }
  let!(:post4) { Post.create(author: user1, title: 'Post 04', text: 'Hello World!') }

  scenario 'Displays user Profile picture, username, bio and number of posts' do
    visit user_path(user1)
    expect(page).to have_css("img[src='#{user1.photo}']")
    expect(page).to have_content(user1.name)
    expect(page).to have_content(user1.bio)
    expect(page).to have_content("No of Posts: #{user1.posts.count}")
  end

  scenario 'Displays user 3 posts' do
    visit user_path(user1)
    expect(page).to have_content(post2.title)
    expect(page).to have_content(post3.title)
    expect(page).to have_content(post4.title)
  end

  scenario 'Displays Button that lets me view all of a user posts, and redirects to the posts when clicked' do
    visit user_path(user1)
    expect(page).to have_link('See all posts')
    click_link 'See all posts'
    sleep(1)
    expect(current_path).to eq(user_posts_path(user1))
  end

  scenario 'click on user post redirects to that post show page.' do
    visit user_path(user1)

    click_link post2.title
    sleep(1)
    expect(current_path).to eq(user_post_path(user1, post2))
  end

  scenario 'Click to see all posts, it redirects me to the users posts index page.' do
    visit user_path(user1)

    click_link 'See all posts'
    sleep(1)
    expect(current_path).to eq(user_posts_path(user1))
  end
end
