class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :currently, :forecast, :today_high, :today_low, :today_summary, :tonight_summary
end
