require 'rails_helper'

describe CurrentWeather, type: :model do
  it 'can be initialized with attributes', :vcr do
    weather = WeatherService.get_current_weather(lat: "39.7392358", lng: "-104.990251")

    current_weather = weather[:currently]
    currently = CurrentWeather.new(current_weather)

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
