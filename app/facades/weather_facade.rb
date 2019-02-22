class WeatherFacade
  def self.get_forecast(city_state)
    weather_json = WeatherService.get_forecast(get_coordinates(city_state))
    Forecast.new(weather_attributes(weather_json))
  end

  private

  def self.get_coordinates(city_state)
    GeocodingService.get_lat_lng(city_state)
  end

  def self.weather_attributes(weather_json)
    {
      currently: Weather.new(weather_json[:currently]),
      today_summary: weather_json[:daily][:summary],
      hourly: weather_json[:hourly][:data].map{|weather_info| Weather.new(weather_info) },
      daily: weather_json[:daily][:data].map{|weather_info| Weather.new(weather_info) }
    }
  end
end
