require 'rails_helper'

RSpec.describe 'Authentications', type: :request do
  describe 'POST /login' do
    let(:user) { FactoryBot.create(:user, username: 'test') }

    it 'authenticates the user' do
      post '/api/v1/login', params: { username: user.username }

      expect(response).to have_http_status(:created)
    end

    it 'returns error when username does not exist' do
      post '/api/v1/login', params: { username: 'test1' }
    end
  end
end
