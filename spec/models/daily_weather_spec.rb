require 'rails_helper'

describe DailyWeather, type: :model do
  it 'can be initialized with attributes', :vcr do
    weather = WeatherService.get_forecast(lat: "39.7392358", lng: "-104.990251")

    first_day_weather = weather[:daily][:data].first
    daily = DailyWeather.new(first_day_weather)

    expect(daily.time).to eq(first_day_weather[:time])
    expect(daily.summary).to eq(first_day_weather[:summary])
    expect(daily.icon).to eq(first_day_weather[:icon])
    expect(daily.precipProbability).to eq(first_day_weather[:precipProbability])
    expect(daily.precipType).to eq(first_day_weather[:precipType])
    expect(daily.temperatureHigh).to eq(first_day_weather[:temperatureHigh])
    expect(daily.temperatureLow).to eq(first_day_weather[:temperatureLow])
    expect(daily.apparentTemperatureHigh).to eq(first_day_weather[:apparentTemperatureHigh])
    expect(daily.apparentTemperatureLow).to eq(first_day_weather[:apparentTemperatureLow])
    expect(daily.humidity).to eq(first_day_weather[:humidity])
    expect(daily.uvIndex).to eq(first_day_weather[:uvIndex])
    expect(daily.temperatureMin).to eq(first_day_weather[:temperatureMin])
    expect(daily.temperatureMax).to eq(first_day_weather[:temperatureMax])
    expect(daily.apparentTemperatureMax).to eq(first_day_weather[:apparentTemperatureMax])
    expect(daily.apparentTemperatureMin).to eq(first_day_weather[:apparentTemperatureMin])
  end
end
