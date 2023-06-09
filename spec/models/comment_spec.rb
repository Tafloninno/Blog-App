require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let!(:post) { user.posts.build(title: 'Hello', text: 'This is my first post') }
  subject { post.comments.build(author: user, text: 'Great post!') }

  before { user.save && post.save }

  it 'validates the presence of text' do
    subject.text = nil
    expect(subject).to_not be_valid
  end

  it 'belongs to an author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'should be linked to a post' do
    subject.post = nil
    expect(subject).to_not be_valid
  end
end
