require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(name: 'Luis', photo: 'image1',
             bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.
             Nulla aliquet et lorem at volutpat. Aenean vel justo diam.
             Vivamus ultricies vulputate dolor, et molestie turpis convallis et.
             In sed metus.', posts_counter: 0)
  end

  before { subject.save }

  it 'Name must not be blank' do
    subject.name = ''
    expect(subject).to_not be_valid
  end

  it 'PostsCounter must be integer greater than or equal to zero' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'most_recent_posts method returns last 3 posts' do
    subject.posts.create!(title: 'New post 1',
                          text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                                  Proin eros tellus, facilisis eget nisi sed, tempus laoreet neque.
                                  Nunc gravida sit amet elit in euismod. Etiam eu tincidunt augue.
                                  Fusce.', comments_counter: 0, likes_counter: 0)
    post2 = subject.posts.create!(title: 'New post 2',
                                  text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                                  Praesent elementum turpis in sapien feugiat, sit amet ultrices dui pretium.
                                  Interdum et malesuada fames ac ante ipsum primis in faucibus.
                                  Ut.', comments_counter: 0, likes_counter: 0)
    post3 = subject.posts.create!(title: 'New post 3',
                                  text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                                  Nulla sit amet eros accumsan, cursus metus lobortis, tincidunt erat.
                                  Nam blandit odio risus, et placerat sem gravida vitae.
                                  Nunc rhoncus sollicitudin.', comments_counter: 0, likes_counter: 0)
    post4 = subject.posts.create!(title: 'New post 4',
                                  text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                                  Duis a interdum odio. Cras dictum convallis euismod.
                                  Pellentesque imperdiet elementum augue ut bibendum. Donec ut risus urna.
                                  Etiam fringilla lacinia dui.', comments_counter: 0, likes_counter: 0)
    expect(subject.most_recent_posts).to match_array([post4, post3, post2])
  end
end
