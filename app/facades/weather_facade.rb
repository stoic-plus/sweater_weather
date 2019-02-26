class WeatherFacade
  def self.get_forecast(city_state)
    forecast = Cache.read_forecast(city_state)
    unless forecast
      weather_json = get_weather_json(city_state, :forecast)
      forecast = Forecast.new(weather_attributes(weather_json))
      Cache.write_forecast(city_state, forecast)
    end
    forecast
  end

  def self.get_daily_weather(city_state)
    DailyWeather.from_weather_data(get_weather_json(city_state, :daily))
  end

  def self.get_current_weather(city_state)
    current_weather = Cache.read_current_weather(city_state)
    unless current_weather
      current_weather = CurrentWeather.new(get_weather_json(city_state, :current))
      Cache.write_current_weather(city_state, current_weather)
    end
    current_weather
  end

  def self.get_daily_icons(daily_weather=nil)
    daily_weather = get_daily_weather unless daily_weather
    daily_weather.group_by {|dw| dw.icon }.reduce({}) do |icon_and_count, (icon, dw)|
      icon_and_count[icon] = dw.count
      icon_and_count
    end
  end

  private

  def self.get_weather_json(city_state, type)
    return WeatherService.get_forecast(get_coordinates(city_state)) if type == :forecast
    return WeatherService.get_daily_weather(get_coordinates(city_state))[:daily][:data] if type == :daily
    return WeatherService.get_current_weather(get_coordinates(city_state))[:currently] if type == :current
  end

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
