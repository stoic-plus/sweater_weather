require 'rails_helper'

describe 'User Login', type: :request do
  context 'when sending a POST to /api/v1/sessions with valid email and password' do
    it 'returns appropriate JSON' do
      user = User.create(email: "whatever@example.com", password: "password", password_confirmation: "password")
      email = "whatever@example.com"
      password = "password"

      headers = {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      post '/api/v1/sessions', params: { email: email, password: password, headers: headers }

      json = JSON.parse(response.body)
      expect(json["api_key"]).to eq(user.api_key)
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")
      expect(response.status).to eq(200)
    end
  end
  context 'when sending a POST to /api/v1/sessions with invalid email and password' do
    it 'returns appropriate JSON' do
      User.create(email: "whatever@example.com", password: "password", password_confirmation: "password")

      email = "whatever@example.com"
      password = "password123"

      headers = {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      post '/api/v1/sessions', params: { email: email, password: password, headers: headers }

      json = JSON.parse(response.body)["data"]["attributes"]
      expect(json).to_not have_key("api_key")
      expect(response.content_type).to eq("application/json")
      expect(response.status).to eq(400)
    end
  end
end
