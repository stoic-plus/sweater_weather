require 'rails_helper'

describe HourlyWeather, type: :model do
  it 'can be initialized with attributes', :vcr do
    weather = WeatherService.get_forecast("39.7392358", "-104.990251")

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
  it 'can be initialized with current weather attributes', :vcr do
    weather = WeatherService.get_forecast("39.7392358", "-104.990251")

    current_weather = weather[:currently]
    currently = HourlyWeather.new(current_weather)

    expect(currently.time).to eq(current_weather[:time])
    expect(currently.summary).to eq(current_weather[:summary])
    expect(currently.icon).to eq(current_weather[:icon])
    expect(currently.precipProbability).to eq(current_weather[:precipProbability])
    expect(currently.temperature).to eq(current_weather[:temperature])
    expect(currently.apparentTemperature).to eq(current_weather[:apparentTemperature])
    expect(currently.humidity).to eq(current_weather[:humidity])
    expect(currently.pressure).to eq(current_weather[:pressure])
    expect(currently.uvIndex).to eq(current_weather[:uvIndex])
    expect(currently.visibility).to eq(current_weather[:visibility])
    expect(currently.ozone).to eq(current_weather[:ozone])
    expect(currently.nearestStormDistance).to eq(current_weather[:nearestStormDistance])
    expect(currently.nearestStormBearing).to eq(current_weather[:nearestStormBearing])
  end
end
