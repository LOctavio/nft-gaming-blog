require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.create!(name: 'Luis', photo: 'image1' , bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla aliquet et lorem at volutpat. Aenean vel justo diam. Vivamus ultricies vulputate dolor, et molestie turpis convallis et. In sed metus.', posts_counter: 0)
  subject { user.posts.new(title: 'New post 1', text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin eros tellus, facilisis eget nisi sed, tempus laoreet neque. Nunc gravida sit amet elit in euismod. Etiam eu tincidunt augue. Fusce.', comments_counter: 0, likes_counter: 0) }
  before { subject.save }
  
  it 'title must not be blank' do
    subject.title = ''
    expect(subject).to_not be_valid
  end

  it 'Title must not exceed 250 characters' do
    subject.title = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec tempus sodales ultrices. Donec lobortis ante eget sapien bibendum posuere. Maecenas fringilla nec tellus non imperdiet. Proin in lacus ut enim aliquam porttitor vel non lectus. Nulla quis enim interdum, pellentesque sem eget, mattis velit. Phasellus ante neque, tempus et nibh in, euismod laoreet ipsum. Pellentesque elit lorem, accumsan ac fringilla et, finibus ut est. Quisque laoreet malesuada arcu, eget elementum risus eleifend vitae.
    Etiam urna urna, dignissim eu eros quis, efficitur sollicitudin purus. Nulla porttitor elit non tellus malesuada tempus. Sed quis leo dignissim, bibendum tellus convallis, pretium est. Phasellus congue erat consequat, aliquam lacus vitae, venenatis elit. Ut non nulla id turpis semper faucibus vel id urna. Curabitur auctor, risus in vulputate scelerisque, mauris nisi aliquam elit, et suscipit quam enim id urna. Mauris pretium varius dictum. Maecenas justo erat, vulputate vel diam quis, tincidunt tempus felis.
    Vestibulum cursus leo elit, vitae euismod neque fermentum vitae. Praesent et sodales est, at consectetur dui. In in vulputate mauris, eget egestas sapien. Duis dapibus, lacus eget venenatis facilisis, diam lacus rutrum nunc, laoreet commodo lacus libero et sem. Nam dignissim ultrices nisl, sed condimentum lorem sodales nec. Vivamus non cursus augue. Fusce non dolor laoreet, placerat felis et, hendrerit odio. Duis in ipsum ac quam hendrerit ullamcorper. Etiam a congue risus. Suspendisse potenti. Pellentesque et risus ut augue gravida scelerisque.
    Donec a urna vitae massa molestie ultricies nec at nisi. Praesent elementum, tortor id tristique feugiat, eros libero tincidunt ex, porta tempor.'
    expect(subject).to_not be_valid
  end

  it 'CommentsCounter must be integer greater than or equal to zero' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'LikesCounter must be integer greater than or equal to zero' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'most_recent_comments method returns last 5 comments' do
    author = User.create!(name: 'Octavio', photo: 'image2', bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ullamcorper cursus sollicitudin. Etiam nulla augue, pretium at diam tempus, ornare mollis nunc. Ut enim dolor, fringilla vitae metus id, suscipit.', posts_counter: 0)
    comment1 = author.comments.create!(text: 'New comment 1', post: subject)
    comment2 = author.comments.create!(text: 'New comment 2', post: subject)
    comment3 = author.comments.create!(text: 'New comment 3', post: subject)
    comment4 = author.comments.create!(text: 'New comment 4', post: subject)
    comment5 = author.comments.create!(text: 'New comment 5', post: subject)
    comment6 = author.comments.create!(text: 'New comment 6', post: subject)
    expect(subject.most_recent_comments).to match_array([comment6, comment5, comment4, comment3, comment2])
  end

  it 'updates post counter after saving a post' do
    expect(subject.author.posts_counter).to eq(1)
  end
end
