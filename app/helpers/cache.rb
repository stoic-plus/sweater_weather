module Cache
  BACKGROUND_EXPIRATION = 1.day
  FORECAST_EXPIRATION = 1.hour
  def self.read_background(location)
    Rails.cache.read("#{location}-background")
  end
  def self.write_background(location, background_url)
    Rails.cache.write("#{location}-background", background_url, expires_in: BACKGROUND_EXPIRATION)
  end
  def self.read_forecast(location)
    Rails.cache.read(location)
  end
  def self.write_forecast(location, forecast)
    Rails.cache.write(location, forecast, expires_in: FORECAST_EXPIRATION)
  end
end
