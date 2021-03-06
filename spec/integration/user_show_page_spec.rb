require 'rails_helper'

RSpec.describe 'Show page', type: :system do
  describe 'show page' do
    before(:each) do
      User.create(name: 'Luis', email: 'luis@gmail.com', password: '123456', photo: 'image1',
                  bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', posts_counter: 0)
      visit new_user_session_path
      fill_in 'Username', with: 'luis@gmail.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      id = User.all[0].id
      visit user_path(id)
    end
    it 'Can see the profile image' do
      image = page.find('img', id: "profile-image#{User.all[0].id}")
      expect(image['src']).to have_content 'profile_icon'
    end
    it "Can see the user's name" do
      expect(page).to have_content 'Luis'
    end
    it 'Can see the number of posts' do
      User.all[0].posts.create!(title: 'New post 4',
                                text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                                comments_counter: 0, likes_counter: 0)
      visit user_path(User.all[0].id)
      expect(page).to have_content 'Number of posts: 1'
    end
    it "I can see the user's bio." do
      expect(page).to have_content User.all[0].bio
    end
    it "I can see the user's first 3 posts." do
      User.all[0].posts.create!(
        title: 'New post 1',
        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        comments_counter: 0, likes_counter: 0
      )
      User.all[0].posts.create!(
        title: 'New post 2',
        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        comments_counter: 0, likes_counter: 0
      )
      User.all[0].posts.create!(
        title: 'New post 3',
        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        comments_counter: 0, likes_counter: 0
      )
      User.all[0].posts.create!(
        title: 'New post 4',
        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        comments_counter: 0, likes_counter: 0
      )
      visit user_path(User.all[0].id)
      post = page.all('div', class: 'post-preview')
      expect(post.count).to eq(3)
    end
    it "I can see a button that lets me view all of a user's posts." do
      expect(page).to have_button('See all posts')
    end
    it "When I click a user's post, it redirects me to that post's show page." do
      User.all[0].posts.create!(
        title: 'New post 4',
        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        comments_counter: 0, likes_counter: 0
      )
      visit user_path(User.all[0].id)
      user_id = User.all[0].id
      post_id = User.first.posts[0]
      link = page.all('a', class: 'post-preview-link')[0]
      link.click
      expect(page).to have_current_path(user_post_path(user_id: user_id, id: post_id))
    end
    it "When I click a user's post, it redirects me to that post's show page." do
      User.all[0].posts.create!(
        title: 'New post 4',
        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        comments_counter: 0, likes_counter: 0
      )
      visit user_path(User.all[0].id)
      user_id = User.all[0].id
      click_button 'See all posts'
      expect(page).to have_current_path(user_posts_path(user_id: user_id))
    end
  end
end
