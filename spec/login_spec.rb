require 'rails_helper'

RSpec.describe 'Login page', type: :system do
    describe 'login page' do
        before(:each) do
            DatabaseCleaner.clean
            Rails.application.load_seed
            visit new_user_session_path
        end
        it 'Can see the user name input' do
            expect(page).to have_field('Username')
        end

        it 'Can see the password input'do
            expect(page).to have_field('Password')
        end

        it 'Can see the submit button'do
            expect(page).to have_button('Log in')
        end

        it 'When I click the submit button without filling in the username and the password, I get a detailed error.' do
            click_button 'Log in'
            expect(page).to have_content('Invalid Email or password.')
        end
    
        it 'When I click the submit button after filling in the username and the password with incorrect data, I get a detailed error.' do
            fill_in 'Username', with: 'user@example.com'
            fill_in 'Password', with: 'password'
            click_button 'Log in'
            expect(page).to have_content('Invalid Email or password.')
        end

        it 'When I click the submit button after filling in the username and the password with correct data, I am redirected to the root page.' do
            fill_in 'Username', with: 'luis@example.com'
            fill_in 'Password', with: '123456'
            click_button 'Log in'
            expect(page).to have_current_path(root_path)
        end
    end
end