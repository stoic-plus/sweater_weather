require 'rails_helper'

describe 'Create Favorite', type: :request do
  context 'when sending a POST to /api/v1/favorites with location and api key' do
    it 'responds with appropriate json and 200 status, updates user\'s favorites, and creates location', :vcr do
      user = User.create(
        email: "whatever@example.com",
        password: "password",
        password_confirmation: "password",
        api_key: 'ashdgashdgajhsdga2342'
      )
      headers = {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }

      expect(user.favorites).to eq([])
      expect(Location.count).to eq(0)
      expect(Favorite.count).to eq(0)

      post '/api/v1/favorites', params: { location: "Denver, CO", api_key: user.api_key, headers: headers }

      json = JSON.parse(response.body)["data"]["attributes"]
      expect(json["message"]).to eq("successfully created favorite")
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")
      expect(response.status).to eq(200)

      expect(Location.count).to eq(1)
      expect(Favorite.count).to eq(1)
      expect(user.locations.first).to eq(Location.first)
    end
    it 'responds appropriately, adds to favorites but does not create location if exists' do
      user = User.create(
        email: "whatever@example.com",
        password: "password",
        password_confirmation: "password",
        api_key: 'ashdgashdgajhsdga2342'
      )
      Location.create(
        city: 'denver',
        state: 'co',
        latitude: '39.7392358',
        longitude: '-104.990251'
      )

      headers = {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }

      expect(user.favorites).to eq([])
      expect(Location.count).to eq(1)
      expect(Favorite.count).to eq(0)

      post '/api/v1/favorites', params: { location: "Denver, CO", api_key: user.api_key, headers: headers }

      expect(Location.count).to eq(1)
      expect(Favorite.count).to eq(1)
      expect(user.locations.first).to eq(Location.first)
    end
  end
  context 'when sending a POST to /api/v1/favorites with location only' do
    it 'responds with appropriate json and 401 status', :vcr do
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
  context 'when sending a POST to /api/v1/favorites with location and invalid api key' do
    it 'responds with appropriate json and 404 status', :vcr do
      User.create(
        email: "whatever@example.com",
        password: "password",
        password_confirmation: "password",
        api_key: 'ashdgashdgajhsdga2342'
      )

      headers = {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      post '/api/v1/favorites', params: { location: "Denver, CO", api_key: 'WRONG', headers: headers }

      json = JSON.parse(response.body)["data"]["attributes"]
      expect(json["message"]).to eq('invalid api_key')
      expect(response.content_type).to eq("application/json")
      expect(response.status).to eq(404)
    end
  end
end
