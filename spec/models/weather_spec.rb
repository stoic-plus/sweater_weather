require 'rails_helper'

describe Weather, type: :model do
  it 'can be intialized with attributes', :vcr do
    weather = WeatherService.get_forecast(lat: "39.7392358", lng: "-104.990251")

    first_hour_weather = weather[:hourly][:data].first
    weather = Weather.new(first_hour_weather)
    expect(weather.summary).to eq(first_hour_weather[:summary])
    expect(weather.icon).to eq(first_hour_weather[:icon])
    expect(weather.precipProbability).to eq(first_hour_weather[:precipProbability])
    expect(weather.humidity).to eq(first_hour_weather[:humidity])
    expect(weather.uvIndex).to eq(first_hour_weather[:uvIndex])
  end
end
