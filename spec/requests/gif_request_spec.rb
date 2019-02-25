require 'rails_helper'

describe 'Gif Request', type: :request do
  context 'sending a GET to /api/v1/gifs with valid location and api_key' do
    it 'returns appropriate gifs for daily weather for location' do
      user = User.create(
        email: "whatever@example.com",
        password: "password",
        password_confirmation: "password",
        api_key: 'ashdgashdgajhsdga2342'
      )

      get '/api/v1/gifs', params: {location: 'denver,co', api_key: user.api_key}

      gifs = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")
      expect(response.status).to eq(200)

      expect(gifs.size).to eq(8)
      gifs.each do |gif|
        expect(gif["attributes"]).to have_key("time")
        expect(gif["attributes"]).to have_key("summary")
        expect(gif["attributes"]["url"]).to match(/https:\/\/giphy.com\/gifs\/\w+/)
      end
    end
  end
end
