require 'rails_helper'

RSpec.describe 'Users controller', type: :request do
  describe 'GET /users' do
    before do
      get users_path
    end

    it 'returns a 200 status code' do
      expect(response).to have_http_status(200)
    end

    it "renders the 'index' template" do
      expect(response).to render_template('index')
    end

    it "includes 'List of all users' in the response body" do
      expect(response.body).to include('List of all users:')
    end
  end

  describe 'GET /users/user_id' do
    before do
      user = User.create(name: 'Tom', photo: 'https://example.com/photo.jpg')
      get user_path(user)
    end

    it 'returns a 200 status code' do
      expect(response).to have_http_status(200)
    end

    it "renders the 'show' template" do
      expect(response).to render_template('show')
    end

    it "includes 'No of Posts: in the response body" do
      expect(response.body).to include('No of Posts:')
    end
  end
end
