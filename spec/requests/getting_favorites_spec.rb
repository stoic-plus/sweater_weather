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

      json = JSON.parse(response.body)["data"]["attributes"]
      expect(json.size).to eq(2)
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")
      expect(response.status).to eq(200)
    end
  end
end