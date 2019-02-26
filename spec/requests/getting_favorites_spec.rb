require 'rails_helper'

describe 'Getting Favorites', type: :request do
  context 'when a GET is made to /api/v1/favorites with valid API key' do
    it 'returns current weather for user\s favorites', :vcr do
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
      headers = {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }

      get '/api/v1/favorites', params: { api_key: user.api_key, headers: headers }

      json = JSON.parse(response.body)["data"]
      expect(json.size).to eq(2)
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")
      expect(response.status).to eq(200)

      expect(json.first["attributes"]["location"]).to eq("Denver, CO")
      expect(json.second["attributes"]["location"]).to eq("Austin, TX")
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
    it 'returns cached current weather for user\s favorites if under expiration', :vcr do
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
      user.locations << lc_1
      headers = {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      Rails.cache.write("denver,co-current", WeatherService.get_current_weather(lat: "39.7392358", lng: "-104.990251"), expires_in: 40.minutes)

      expect(CurrentWeather).not_to receive(:for_location)
      expect(WeatherService).not_to receive(:get_current_weather)

      travel 30.minutes
      
      get '/api/v1/favorites', params: { api_key: user.api_key, headers: headers }

      json = JSON.parse(response.body)["data"]
      expect(json.size).to eq(2)
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")
      expect(response.status).to eq(200)

      expect(json.first["attributes"]["location"]).to eq("Denver, CO")
      expect(json.second["attributes"]["location"]).to eq("Austin, TX")
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
  context 'when a GET is made to /api/v1/favorites without API key' do
    it 'responds with appropriate json and 401 status', :vcr do
      headers = {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      get '/api/v1/favorites', params: { location: "Denver, CO", headers: headers }

      json = JSON.parse(response.body)["data"]["attributes"]
      expect(json["message"]).to eq("must provide api_key")
      expect(response.content_type).to eq("application/json")
      expect(response.status).to eq(401)
    end
  end
  context 'when a GET is made to /api/v1/favorites with invalid api key' do
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
      get '/api/v1/favorites', params: { location: "Denver, CO", api_key: 'WRONG', headers: headers }

      json = JSON.parse(response.body)["data"]["attributes"]
      expect(json["message"]).to eq('invalid api_key')
      expect(response.content_type).to eq("application/json")
      expect(response.status).to eq(404)
    end
  end
end
