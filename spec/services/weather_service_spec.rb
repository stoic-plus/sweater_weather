require 'rails_helper'

describe WeatherService, type: :service do
  let(:service) { WeatherService }
  describe 'class methods' do
    context 'get_forecast' do
      it 'returns current, hourly, and weekly weather JSON data' do
        forecast = service.get_forecast("denver,co")

        expect(forecast).to have_key(:latitude)
        expect(forecast).to have_key(:longitude)
        expect(forecast).to have_key(:timezone)
        currently = forecast[:currently]
        expect(currently).to have_key(:time)
        expect(currently).to have_key(:summary)
        expect(currently).to have_key(:icon)
        expect(currently).to have_key(:nearestStormDistance)
        expect(currently).to have_key(:precipProbability)
        expect(currently).to have_key(:apparentTemperature)
        expect(currently).to have_key(:uvIndex)

        hourly = forecast[:hourly]
        expect(hourly).to have_key(:summary)
        expect(hourly).to have_key(:icon)
        expect(hourly).to have_key(:data)
        expect(hourly[:data].size).to eq(48)

        first_hour = hourly[:data].first
        expect(first_hour).to have_key(:time)
        expect(first_hour).to have_key(:summary)
        expect(first_hour).to have_key(:icon)
        expect(first_hour).to have_key(:nearestStormDistance)
        expect(first_hour).to have_key(:precipProbability)
        expect(first_hour).to have_key(:apparentTemperature)
        expect(first_hour).to have_key(:uvIndex)

        daily = forecast[:daily]
        expect(daily).to have_key(:summary)
        expect(daily).to have_key(:icon)
        expect(daily).to have_key(:data)
        expect(daily[:data].size).to eq(8)
        first_day = daily[:data].first
        expect(first_day).to have_key(:time)
        expect(first_day).to have_key(:summary)
        expect(first_day).to have_key(:icon)
        expect(first_day).to have_key(:nearestStormDistance)
        expect(first_day).to have_key(:precipProbability)
        expect(first_day).to have_key(:apparentTemperature)
        expect(first_day).to have_key(:uvIndex)
      end
    end
  end
end
