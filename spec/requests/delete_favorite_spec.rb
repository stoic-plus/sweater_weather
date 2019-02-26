require 'rails_helper'

describe 'Deleting Favorites', type: :request do
  context 'when a DELETE is made to /api/v1/favorites with location and valid API key' do
    it 'updates user\s favorites but returns current weather for all user\s previous favorites', :vcr do
      user = User.create(
        email: "whatever@example.com",
        password: "password",
        password_confirmation: "password",
        api_key: 'ashdgashdgajhsdga2342'
      )
      lc_1 = Location.create(
        city: 'denver',
        state: 'co',
        latitude: '39.7392358',
        longitude: '-104.990251'
      )
      lc_2 = Location.create(
        city: 'austin',
        state: 'tx',
        latitude: '30.2672',
        longitude: '-97.7431'
      )
      user.locations << lc_1
      user.locations << lc_2
      expect(Location.count).to eq(2)
      expect(Favorite.count).to eq(2)
      expect(user.locations.size).to eq(2)

      headers = {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }

      delete '/api/v1/favorites', params: { location: "Denver, CO", api_key: user.api_key, headers: headers }

      expect(Favorite.count).to eq(1)
      expect(user.locations.size).to eq(1)
      json = JSON.parse(response.body)["data"]
      expect(json.size).to eq(2)
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")
      expect(response.status).to eq(200)

      expect(json.first["attributes"]["location"]).to eq("Denver,CO")
      expect(json.second["attributes"]["location"]).to eq("Austin,TX")
      json.each do |location_json|
        expect(location_json["attributes"]["current_weather"]).to have_key("summary")
        expect(location_json["attributes"]["current_weather"]).to have_key("precipProbability")
        expect(location_json["attributes"]["current_weather"]).to have_key("humidity")
        expect(location_json["attributes"]["current_weather"]).to have_key("uvIndex")
        expect(location_json["attributes"]["current_weather"]).to have_key("time")
        expect(location_json["attributes"]["current_weather"]).to have_key("temperature")
        expect(location_json["attributes"]["current_weather"]).to have_key("apparentTemperature")
      end
    end
  end
  context 'when a DELETE is made to /api/v1/favorites without API key' do
    it 'responds with appropriate json and 401 status', :vcr do
      headers = {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      delete '/api/v1/favorites', params: { location: "Denver, CO", headers: headers }

      json = JSON.parse(response.body)["data"]["attributes"]
      expect(json["message"]).to eq("must provide api_key")
      expect(response.content_type).to eq("application/json")
      expect(response.status).to eq(401)
    end
  end
  context 'when a DELETE is made to /api/v1/favorites with invalid api key' do
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
      delete '/api/v1/favorites', params: { location: "Denver, CO", api_key: 'WRONG', headers: headers }

      json = JSON.parse(response.body)["data"]["attributes"]
      expect(json["message"]).to eq('invalid api_key')
      expect(response.content_type).to eq("application/json")
      expect(response.status).to eq(404)
    end
  end
end
