require 'rails_helper'

describe FavoriteWeather, type: :model do
  it 'can be initialized with location and current weather', :vcr do
    current_weather_json = WeatherService.get_current_weather(lat: "39.7392358", lng: "-104.990251")
    location = "Denver, CO"

    favorite_weather = FavoriteWeather.new(location, CurrentWeather.new(current_weather_json))

    expect(favorite_weather.location).to eq(location)
    expect(favorite_weather.current_weather).to be_a(CurrentWeather)
  end
end
