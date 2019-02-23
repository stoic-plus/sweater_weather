class Forecast
  attr_reader :currently,
              :today_summary,
              :tonight_summary,
              :hourly_forecast,
              :daily_forecast,
              :today_high,
              :today_low,
              :id

  @@count = 0
  def initialize(weather_data)
    @id = @@count
    @@count += 1
    @currently = weather_data[:currently]
    @today_summary = weather_data[:today_summary]
    @hourly_forecast = weather_data[:hourly_forecast]
    @daily_forecast = weather_data[:daily_forecast]
    @today_high = @daily_forecast.first.temperatureHigh
    @today_low = @daily_forecast.first.temperatureLow
    @tonight_summary = @daily_forecast.first.summary
  end
end
