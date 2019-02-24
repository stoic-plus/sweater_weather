require 'rails_helper'

describe HourlyWeather, type: :model do
  it 'can be initialized with attributes', :vcr do
    weather = WeatherService.get_forecast(lat: "39.7392358", lng: "-104.990251")

    first_hour_weather = weather[:hourly][:data].first
    hourly = HourlyWeather.new(first_hour_weather)

    expect(hourly.time).to eq(first_hour_weather[:time])
    expect(hourly.summary).to eq(first_hour_weather[:summary])
    expect(hourly.icon).to eq(first_hour_weather[:icon])
    expect(hourly.precipProbability).to eq(first_hour_weather[:precipProbability])
    expect(hourly.temperature).to eq(first_hour_weather[:temperature])
    expect(hourly.apparentTemperature).to eq(first_hour_weather[:apparentTemperature])
    expect(hourly.humidity).to eq(first_hour_weather[:humidity])
    expect(hourly.pressure).to eq(first_hour_weather[:pressure])
    expect(hourly.uvIndex).to eq(first_hour_weather[:uvIndex])
    expect(hourly.visibility).to eq(first_hour_weather[:visibility])
    expect(hourly.ozone).to eq(first_hour_weather[:ozone])
  end
end
