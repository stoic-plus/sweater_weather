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

      weather_gifs = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")
      expect(response.status).to eq(200)

      expect(weather_gifs.size).to eq(8)
      weather_gifs.each do |weather_gif|
        expect(weather_gif).to have_key(:id)
        expect(weather_gif[:type]).to eq("weather_gif")
        expect(weather_gif[:attributes]).to have_key(:time)
        expect(weather_gif[:attributes]).to have_key(:summary)
        expect(weather_gif[:attributes]).to have_key(:gif)
        expect(weather_gif[:attributes][:gif]).to have_key(:search_string)
        expect(weather_gif[:attributes][:gif][:embed_url]).to match(/https:\/\/giphy.com\/embed\/\w+/)
        expect(weather_gif[:attributes][:gif][:original_url]).to match(/https:\/\/media\d{1}.giphy.com\/media\/\w+\/giphy.gif/)
      end
    end
  end
end
