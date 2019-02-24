require 'rails_helper'

describe CurrentWeather, type: :model do
  describe 'class methods' do
    context '.for_location' do
      it 'returns instance of itself given lat and lng', :vcr do
        current_weather_json = WeatherService.get_current_weather(lat: "39.7392358", lng: "-104.990251")[:currently]
        current_weather = CurrentWeather.for_location(lat: "39.7392358", lng: "-104.990251")

        expect(current_weather).to be_a(CurrentWeather)

        expect(current_weather.time).to eq(current_weather_json[:time])
        expect(current_weather.summary).to eq(current_weather_json[:summary])
        expect(current_weather.icon).to eq(current_weather_json[:icon])
        expect(current_weather.precipProbability).to eq(current_weather_json[:precipProbability])
        expect(current_weather.temperature).to eq(current_weather_json[:temperature])
        expect(current_weather.apparentTemperature).to eq(current_weather_json[:apparentTemperature])
        expect(current_weather.humidity).to eq(current_weather_json[:humidity])
        expect(current_weather.pressure).to eq(current_weather_json[:pressure])
        expect(current_weather.uvIndex).to eq(current_weather_json[:uvIndex])
        expect(current_weather.visibility).to eq(current_weather_json[:visibility])
        expect(current_weather.ozone).to eq(current_weather_json[:ozone])
        expect(current_weather.nearestStormDistance).to eq(current_weather_json[:nearestStormDistance])
        expect(current_weather.nearestStormBearing).to eq(current_weather_json[:nearestStormBearing])
      end
    end
  end
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
