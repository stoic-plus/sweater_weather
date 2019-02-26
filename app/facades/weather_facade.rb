class WeatherFacade
  def self.get_forecast(city_state)
    forecast = Rails.cache.read(city_state)
    unless forecast
      weather_json = WeatherService.get_forecast(get_coordinates(city_state))
      forecast = Forecast.new(weather_attributes(weather_json))
      Rails.cache.write(city_state, forecast, expires_in: 1.hour)
    end
    forecast
  end

  def self.get_daily_weather(city_state)
    weather_json = WeatherService.get_daily_weather(get_coordinates(city_state))[:daily][:data]
    weather_json.map do |raw_daily|
      DailyWeather.new(raw_daily)
    end
  end

  def self.get_daily_icons(daily_weather=nil)
    daily_weather = get_daily_weather unless daily_weather
    daily_weather.group_by {|dw| dw.icon }.reduce({}) do |icon_and_count, (icon, dw)|
      icon_and_count[icon] = dw.count
      icon_and_count
    end
  end

  private

  def self.get_coordinates(city_state)
    location = Location.find_or_make_by(city_state)
    {lat: location.latitude, lng: location.longitude}
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
