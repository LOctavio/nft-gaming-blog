require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'Response status is correct' do
      get '/'
      expect(response).to have_http_status(200)
    end

    it 'The correct template is rendered' do
      get '/'
      expect(response).to render_template(:index)
    end

    it 'The response body includes correct placeholder text' do
      get '/'
      expect(response.body).to include('Here is a list of all users')
    end
  end

  describe 'GET /show' do
    it 'Response status is correct' do
      get '/users/1'
      expect(response).to have_http_status(200)
    end

    it 'The correct template is rendered' do
      get '/users/1'
      expect(response).to render_template(:show)
    end

    it 'The response body includes correct placeholder text' do
      get '/users/1'
      expect(response.body).to include('Here is the info for a given user')
    end
  end
end
