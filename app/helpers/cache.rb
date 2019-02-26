module Cache
  BACKGROUND_EXPIRATION = 1.day
  FORECAST_EXPIRATION = 1.hour
  CURRENT_WEATHER_EXPIRATION = 40.minutes
  def self.read_background(location)
    Rails.cache.read("#{location}-background")
  end
  def self.write_background(location, background_url)
    Rails.cache.write("#{location}-background", background_url, expires_in: BACKGROUND_EXPIRATION)
  end
  def self.read_forecast(location)
    Rails.cache.read("#{location}-forecast")
  end
  def self.write_forecast(location, forecast)
    Rails.cache.write("#{location}-forecast", forecast, expires_in: FORECAST_EXPIRATION)
  end
  def self.read_current_weather(location)
    Rails.cache.read("#{location}-current")
  end
  def self.write_current_weather(location, current_weather)
    Rails.cache.write("#{location}-current", current_weather, expires_in: CURRENT_WEATHER_EXPIRATION)
  end
end
