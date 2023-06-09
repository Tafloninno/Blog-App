require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  subject { user.posts.create(title: 'Coding in progress', text: 'One line at a time') }

  describe 'validations' do
    it 'should have a title' do
      post = user.posts.build(title: nil, text: 'One line at a time')
      expect(post).to_not be_valid
    end

    it 'should have text' do
      post = user.posts.build(title: 'Coding in progress', text: nil)
      expect(post).to_not be_valid
    end

    it 'title should not be greater than 250' do
      post = user.posts.build(title: 'Hello world' * 25, text: 'One line at a time')
      expect(post).to_not be_valid
    end

    it 'comments_counter should be an integer' do
      post = user.posts.build(title: 'Coding in progress', text: 'One line at a time', comments_counter: '')
      expect(post).to_not be_valid
    end

    it 'likes_counter should be an integer' do
      post = user.posts.build(title: 'Coding in progress', text: 'One line at a time', likes_counter: '')
      expect(post).to_not be_valid
    end

    it 'comments_counter should be greater than or equal to 0' do
      post = user.posts.build(title: 'Coding in progress', text: 'One line at a time', comments_counter: -1)
      expect(post).to_not be_valid
    end

    it 'likes_counter should be greater than or equal to 0' do
      post = user.posts.build(title: 'Coding in progress', text: 'One line at a time', likes_counter: -1)
      expect(post).to_not be_valid
    end
  end
end
