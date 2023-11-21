require 'rails_helper'

RSpec.feature 'User Index Page' do
  let!(:user1) { User.create(name: 'Qaisar', photo: 'https://avatars.githubusercontent.com/u/123939543?v=4') }
  let!(:user2) { User.create(name: 'Sadaf', photo: 'https://scontent.flyp1-1.fna.fbcdn.net/v/t39.30808-6/327303722_472749338405266_3001739480040132853_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeF4_tyGhLsj-0x9VjgJlkqNm3ssynxzo4CbeyzKfHOjgAhtmlyIDKVjvpqLms30EN0&_nc_ohc=pHAjGiqdW98AX_U59h8&_nc_ht=scontent.flyp1-1.fna&oh=00_AfC1VJ8CgFp7paIuLRPcYnxALfD7edako6yIUGkULxYR1g&oe=6561543F') }
  let!(:post1) { Post.create(author: user1, title: 'Post 01') }
  let!(:post2) { Post.create(author: user2, title: 'Post 02') }

  scenario 'Displays usernames' do
    visit users_path
    expect(page).to have_content(user1.name)
    expect(page).to have_content(user2.name)
  end

  scenario 'Displays profile pictures' do
    visit users_path
    expect(page).to have_css("img[src='#{user1.photo}']")
    expect(page).to have_css("img[src='#{user2.photo}']")
  end

  scenario 'Displays post counts' do
    visit users_path
    expect(page).to have_content("Number of posts: #{user1.posts_counter}")
    expect(page).to have_content("Number of posts: #{user2.posts_counter}")
  end

  scenario 'Redirects to user show page when clicked' do
    visit users_path
    click_link user1.name
    sleep(1)
    expect(current_path).to eq(user_path(user1))
  end
end
