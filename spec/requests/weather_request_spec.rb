require 'rails_helper'

describe 'Weather for a City', type: :request do
  context 'given a request to /forecast with valid city/state in location param' do
    it 'returns JSON with current, next 49 hours, and next week weather data' do
      get '/api/v1/forecast', params: {location: 'denver,co'}

      expect(response).to be_successful

      weather = JSON.parse(response.body, symbolize_names: true)[:data]

      current = weather[:attributes][:currently]
      hourly = weather[:attributes][:hourly_forecast]
      daily = weather[:attributes][:daily_forecast]

      expect(current).to have_key(:time)
      expect(current).to have_key(:summary)
      expect(current).to have_key(:icon)
      expect(current).to have_key(:temperature)
      expect(current).to have_key(:apparentTemperature)
      expect(current).to have_key(:humidity)
      expect(current).to have_key(:visibility)
      expect(current).to have_key(:uvIndex)

      expect(hourly.size).to eq(49)
      first_hour = hourly.first
      expect(first_hour).to have_key(:time)
      expect(first_hour).to have_key(:summary)
      expect(first_hour).to have_key(:icon)
      expect(first_hour).to have_key(:precipProbability)
      expect(first_hour).to have_key(:temperature)
      expect(first_hour).to have_key(:apparentTemperature)

      expect(daily.size).to eq(8)
      first_day = daily.first
      expect(first_day).to have_key(:time)
      expect(first_day).to have_key(:summary)
      expect(first_day).to have_key(:icon)
      expect(first_day).to have_key(:precipProbability)
      expect(first_day).to have_key(:temperatureHigh)
      expect(first_day).to have_key(:temperatureLow)
      expect(first_day).to have_key(:temperatureMin)
      expect(first_day).to have_key(:temperatureMax)
    end
  end
end
