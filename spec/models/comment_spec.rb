require 'rails_helper'

RSpec.describe Comment, type: :model do
  author = User.create!(name: 'Luis', photo: 'image1' , bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla aliquet et lorem at volutpat. Aenean vel justo diam. Vivamus ultricies vulputate dolor, et molestie turpis convallis et. In sed metus.', posts_counter: 0)
  post = author.posts.new(title: 'New post 1', text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin eros tellus, facilisis eget nisi sed, tempus laoreet neque. Nunc gravida sit amet elit in euismod. Etiam eu tincidunt augue. Fusce.', comments_counter: 0, likes_counter: 0)
  subject { author.comments.create!(text: 'New comment 1', post: post) }
  before { subject.save }

  it 'updates comments counter after saving a post' do
    expect(subject.post.comments_counter).to eq(1)
  end
end
