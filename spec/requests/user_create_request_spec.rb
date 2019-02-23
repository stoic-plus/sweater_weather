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
      post '/api/v1/users', params: { user: body , headers: headers }

      json = JSON.parse(response.body)
      expect(json["status"]).to eq(201)
      expect(json).to have_key("api_key")
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")
      expect(response.status).to eq(201)
    end
  end
  context 'when a POST req is made to /api/v1/users with invalid data' do
    it 'returns appropriate JSON' do
      body = {
        "email" => "whatever@example.com",
        "password" => "password",
      }
      headers = {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      post '/api/v1/users', params: { user: body , headers: headers }

      json = JSON.parse(response.body)
      expect(json["status"]).to eq(400)
      expect(json).to_not have_key("api_key")
      expect(response.content_type).to eq("application/json")
      expect(response.status).to eq(400)
    end
  end
end
