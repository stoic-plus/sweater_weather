class WeatherGifSerializer
  include FastJsonapi::ObjectSerializer
  attributes :time, :summary, :gif
end
