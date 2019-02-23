class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :currently,
    :hourly_forecast,
    :daily_forecast,
    :today_high,
    :today_low,
    :today_summary,
    :tonight_summary
end
