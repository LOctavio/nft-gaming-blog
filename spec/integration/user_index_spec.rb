require 'rails_helper'

def create_test_users
  before(:each) do
    visit new_user_session_path
    User.create(name: 'Luis', email: 'luis@gmail.com', password: '123456', photo: 'image1',
                bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', posts_counter: 0)
    User.create(name: 'John', email: 'john@gmail.com', password: '123456', photo: 'image1',
                bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', posts_counter: 0)
    User.create(name: 'Octavio', email: 'octavio@gmail.com', password: '123456', photo: 'image1',
                bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', posts_counter: 0)
    fill_in 'Username', with: 'luis@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
  end
end

RSpec.describe 'User index page', type: :system do
  describe 'I can see the username of all other users' do
    create_test_users
    it 'Can see the user name Octavio' do
      expect(page).to have_content('Octavio')
    end

    it 'Can see the user name John' do
      expect(page).to have_content('John')
    end

    it 'Can see the username Luis' do
      expect(page).to have_content('Luis')
    end
  end

  describe 'I can see the profile picture for each user' do
    create_test_users
    it 'test image for first user' do
      image = page.find('img', id: "profile-image#{User.all[0].id}")
      expect(image['src']).to have_content 'profile_icon'
    end

    it 'test image for second user' do
      image = page.find('img', id: "profile-image#{User.all[1].id}")
      expect(image['src']).to have_content 'profile_icon'
    end

    it 'test image for third user' do
      image = page.find('img', id: "profile-image#{User.all[2].id}")
      expect(image['src']).to have_content 'profile_icon'
    end
  end

  describe 'can see the number of posts each user has written' do
    create_test_users
    it 'can see that first users posts are 1' do
      post = User.find_by(email: 'luis@gmail.com').posts.create!(title: 'New post 4',
                                       text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                                       comments_counter: 0, likes_counter: 0)
      visit users_path
      expect(User.find_by(email: 'luis@gmail.com').posts_counter).to eq 1
    end

    it 'can see that second users posts are 1' do
      post = User.find_by(email: 'john@gmail.com').posts.create!(title: 'New post 4',
                                       text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                                       comments_counter: 0, likes_counter: 0)
      visit users_path
      expect(User.find_by(email: 'john@gmail.com').posts_counter).to eq 1
    end

    it 'can see that third users posts are 1' do
      post = User.find_by(email: 'octavio@gmail.com').posts.create!(title: 'New post 4',
                                       text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                                       comments_counter: 0, likes_counter: 0)
      visit users_path
      expect(User.find_by(email: 'octavio@gmail.com').posts_counter).to eq 1
    end
  end

  describe 'When I click on a user, I am redirected to that user\'s show page' do
    create_test_users
    it 'redirects to when clicked' do
      id = User.all[0].id
      link = page.find_link("user-card-link#{id}")
      link.click
      expect(page).to have_current_path(user_path(id))
    end
  end
end
