require 'rails_helper'

describe Forecast, type: :model do
  it 'can be initialized with weather data', :vcr do
    weather_data = WeatherService.get_forecast(lat: "39.7392358", lng: "-104.990251")
    weather_attributes = {
      currently: CurrentWeather.new(weather_data[:currently]),
      today_summary: weather_data[:hourly][:summary],
      hourly_forecast: weather_data[:hourly][:data].map{|weather_info| HourlyWeather.new(weather_info) },
      daily_forecast: weather_data[:daily][:data].map{|weather_info| DailyWeather.new(weather_info) }
    }
    forecast = Forecast.new(weather_attributes)

    expect(forecast.currently).to eq(weather_attributes[:currently])
    expect(forecast.today_summary).to eq(weather_attributes[:today_summary])
    expect(forecast.hourly_forecast).to eq(weather_attributes[:hourly_forecast])
    expect(forecast.daily_forecast).to eq(weather_attributes[:daily_forecast])
    expect(forecast.today_high).to eq(forecast.daily_forecast.first.temperatureHigh)
    expect(forecast.today_low).to eq(forecast.daily_forecast.first.temperatureLow)
    expect(forecast.tonight_summary).to eq(forecast.daily_forecast.first.summary)
  end
end
