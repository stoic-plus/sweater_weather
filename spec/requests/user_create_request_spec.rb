require 'rails_helper'

describe 'User Creation', type: :request do
  context 'when a POST req is made to /api/v1/users with email, password, and password confirmation' do
    it 'returns appropriate json' do
      body = {
        "email" => "whatever@example.com",
        "password" => "password",
        "password_confirmation" => "password"
      }
      headers = {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      post '/api/v1/users', body, headers

      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")
      expect(response.status).to eq(201)
    end
  end
end
