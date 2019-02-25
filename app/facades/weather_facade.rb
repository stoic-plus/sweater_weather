class WeatherFacade
  def self.get_forecast(city_state)
    weather_json = WeatherService.get_forecast(get_coordinates(city_state))
    Forecast.new(weather_attributes(weather_json))
  end

  def self.get_daily_weather(city_state)
    weather_json = WeatherService.get_daily_weather(get_coordinates(city_state))[:daily][:data]
    weather_json.map do |raw_daily|
      DailyWeather.new(raw_daily)
    end
  end

  private

  def self.get_coordinates(city_state)
    GeocodingService.get_lat_lng(city_state)
  end

  def self.weather_attributes(weather_json)
    {
      currently: CurrentWeather.new(weather_json[:currently]),
      today_summary: weather_json[:hourly][:summary],
      hourly_forecast: HourlyWeather.from_weather_data(weather_json[:hourly][:data]),
      daily_forecast: DailyWeather.from_weather_data(weather_json[:daily][:data])
    }
  end
end
