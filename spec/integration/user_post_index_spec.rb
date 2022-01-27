require 'rails_helper'

RSpec.describe 'Users Post Index Page', type: :system do

    def create_post
        post = User.find_by(email: 'luis@gmail.com').posts.create!(title: 'New post 4', text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis a interdum odio. Cras dictum convallis euismod. Pellentesque imperdiet elementum augue ut bibendum. Donec ut risus urna. Etiam fringilla lacinia dui.', comments_counter: 0, likes_counter: 0)
    end

    def visit_post_index_path user_id
        visit user_posts_path(user_id: user_id)
    end

    def create_post_and_visit_path
        post = create_post
        visit_post_index_path post.author
        post
    end

    def visit_comments_page_and_create_comment post
        visit new_user_post_comment_path(user_id: post.author, post_id: post.id)
        fill_in 'Text', with: 'This is awsome!'
        click_button 'Create'
    end

    describe 'Users Post Index Page' do
        before(:each) do
            create_post
            visit new_user_session_path
            fill_in 'Username', with: 'luis@gmail.com'
            fill_in 'Password', with: '123456'
            click_button 'Log in'
        end
        it 'Can see the profile image' do
            create_post_and_visit_path
            image  = page.find("img", id: "profile-image#{User.first.id}")
            expect(image['src']).to have_content 'profile_icon'
        end

        it "Can see the user's name" do
            expect(page).to have_content 'Luis'
        end

        it "Can see the number of posts" do
            visit user_posts_path(user_id: User.first.id)
            expect(page).to have_content 'Number of posts: 1'
        end

        it "Can see a post's title." do
            create_post_and_visit_path
            expect(page).to have_content 'New post 4'
        end

        it "Can see some of the post's body" do
            create_post_and_visit_path
            expect(page).to have_content 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis a interdum odio. Cras dictum convallis euismod. Pellentesque imperdiet elementum augue ut bibendum. Donec ut risus urna. Etiam fringilla lacinia dui.'
        end


        it "Can see the first comments on a post." do
            post = create_post_and_visit_path
            6.times {visit_comments_page_and_create_comment post }
            visit user_posts_path(user_id: post.author)
            expect(page).to have_content 'This is awsome!'
        end

        it "Can see how many comments a post has" do
            post = create_post_and_visit_path
            6.times {visit_comments_page_and_create_comment post }
            visit user_posts_path(user_id: post.author)
            expect(page).to have_content 'Comments: 6'
        end

        it "Can see how many likes a post has." do
            post = create_post_and_visit_path
            visit user_post_path(user_id: post.author, id: post.id)
            like_button = page.find('button', class: 'like-button')
            3.times { 
                sleep(1)
                like_button.click
            }
            visit user_posts_path(user_id: post.author)
            expect(page).to have_content 'Likes: 3'
        end



        it "Can see a section for pagination if there are more posts than fit on the view" do
            post = create_post
            10.times {create_post}
            visit_post_index_path post.author
            expect(page).to have_button 'Pagination'
        end

        it "Redirects me to that post's show page when I click on a post, " do
            post = create_post
            visit_post_index_path post.author
            post_preview = page.all('a', class: 'post-preview-link')[1]
            post_preview.click
            expect(page).to have_current_path user_post_path(user_id:  post.author, id: post.id)
        end
    end
end