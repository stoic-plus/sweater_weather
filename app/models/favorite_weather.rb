class FavoriteWeather
  attr_reader :id, :location, :current_weather
  @@count = 0
  def initialize(location, current_weather)
    @id = @@count
    @@count += 1
    @location = location
    @current_weather = current_weather
  end
end
