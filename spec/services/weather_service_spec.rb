require 'rails_helper'

describe WeatherService, type: :service do
  let(:service) { WeatherService }
  describe 'class methods' do
    context 'get_forecast' do
      it 'returns current, hourly, and weekly weather JSON data given lat and lng', :vcr do
        forecast = service.get_forecast(lat: "39.7392358", lng: "-104.990251")

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
        expect(hourly[:data].size).to eq(49)

        first_hour = hourly[:data].first
        expect(first_hour).to have_key(:time)
        expect(first_hour).to have_key(:summary)
        expect(first_hour).to have_key(:icon)
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
        expect(first_day).to have_key(:sunriseTime)
        expect(first_day).to have_key(:sunsetTime)
        expect(first_day).to have_key(:summary)
        expect(first_day).to have_key(:icon)
        expect(first_day).to have_key(:apparentTemperatureHigh)
        expect(first_day).to have_key(:apparentTemperatureLow)
        expect(first_day).to have_key(:uvIndex)
      end
    end
    context '.get_current_weather' do
      it 'returns current weather for location given lat and lng', :vcr do
        current_weather = service.get_current_weather(lat: "39.7392358", lng: "-104.990251")

        expect(current_weather).to have_key(:latitude)
        expect(current_weather).to have_key(:longitude)
        expect(current_weather).to have_key(:timezone)
        currently = current_weather[:currently]
        expect(currently).to have_key(:time)
        expect(currently).to have_key(:summary)
        expect(currently).to have_key(:icon)
        expect(currently).to have_key(:nearestStormDistance)
        expect(currently).to have_key(:precipProbability)
        expect(currently).to have_key(:apparentTemperature)
        expect(currently).to have_key(:uvIndex)

        expect(current_weather).to_not have_key(:hourly)
        expect(current_weather).to_not have_key(:daily)
      end
    end
    context '.get_daily_weather' do
      it 'returns daily weather for location given lat and lng', :vcr do
        daily_weather = service.get_daily_weather(lat: "39.7392358", lng: "-104.990251")

        expect(daily_weather).to have_key(:latitude)
        expect(daily_weather).to have_key(:longitude)
        expect(daily_weather).to have_key(:timezone)
        daily = daily_weather[:daily]
        expect(daily).to have_key(:data)
        expect(daily).to have_key(:summary)
        expect(daily).to have_key(:icon)
        first_day = daily[:data].first
        expect(first_day).to have_key(:time)
        expect(first_day).to have_key(:precipType)
        expect(first_day).to have_key(:temperatureHigh)
        expect(first_day).to have_key(:temperatureLow)
        expect(first_day).to have_key(:apparentTemperatureHigh)
        expect(first_day).to have_key(:apparentTemperatureLow)
        expect(first_day).to have_key(:temperatureMin)
        expect(first_day).to have_key(:temperatureMax)

        expect(daily_weather).to_not have_key(:hourly)
        expect(daily_weather).to_not have_key(:currently)
      end
    end
  end
end
