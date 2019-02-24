class FavoriteWeather
  attr_reader :location, :current_weather

  def initialize(location, current_weather)
    @location = location
    @current_weather = current_weather
  end
end
