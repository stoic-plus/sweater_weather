require 'rails_helper'

describe 'Create Favorite', type: :request do
  context 'when sending a POST to /api/v1/favorites with location and api key' do
    it 'responds with appropriate json and 200 status' do
      user = User.create(email: "whatever@example.com", password: "password", password_confirmation: "password")
      headers = {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      post '/api/v1/favorites', params: { location: "Denver, CO", api_key: user.api_key, headers: headers }

      json = JSON.parse(response.body)["data"]["attributes"]
      expect(json["message"]).to eq("successfully created favorite")
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")
      expect(response.status).to eq(200)
    end
  end
  context 'when sending a POST to /api/v1/favorites with location only' do
    it 'responds with appropriate json and 401 status' do
      headers = {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      post '/api/v1/favorites', params: { location: "Denver, CO", headers: headers }

      json = JSON.parse(response.body)["data"]["attributes"]
      expect(json["message"]).to eq("must provide api_key")
      expect(response.content_type).to eq("application/json")
      expect(response.status).to eq(401)
    end
  end
end
