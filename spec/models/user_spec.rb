require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Taflon', photo: 'https://avatars.githubusercontent.com/u/118063058?v=4', post_counter: 10, bio: 'Full-stack developer') }

  before { subject.save! }

  it 'Name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Post counter must be integer' do
    subject.post_counter = 'z'
    expect(subject).to_not be_valid
  end

  it 'Post counter should be 0 or greater' do
    subject.post_counter = -1
    expect(subject).to_not be_valid
  end
end

describe 'Tests:' do
  it 'recent_posts method  return zero(0) when user is created' do
    new_user = User.new(name: 'Elli', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from China.')
    puts new_user.recent_posts
    expect(new_user.recent_posts.count).to eq 0
  end

  it 'recent_posts method return the last 3 posts of the user' do
    new_user = User.create(name: 'Elli', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from China.')
    new_user.recent_posts
  end
end
