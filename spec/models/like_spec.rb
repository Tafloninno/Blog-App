require 'rails_helper'

RSpec.describe Like, type: :model do
  let!(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let!(:post) { user.posts.build(title: 'Coding in progress', text: 'One line at a time') }
  subject { post.likes.build(author: user) }

  before { user.save && post.save }

  it 'belongs to an author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'should be linked to a post' do
    subject.post = nil
    expect(subject).to_not be_valid
  end
end
