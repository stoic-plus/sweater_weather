class FavoritesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location, :current_weather
end
