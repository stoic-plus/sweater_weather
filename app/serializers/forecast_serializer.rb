class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :currently,
    :hourly,
    :daily,
    :today_high,
    :today_low,
    :today_summary,
    :tonight_summary
end
