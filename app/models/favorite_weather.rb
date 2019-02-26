class FavoriteWeather
  attr_reader :id, :location, :current_weather
  @@count = 0
  def initialize(location, current_weather)
    @id = @@count
    @@count += 1
    @location = location
    @current_weather = current_weather
  end

  def self.from_location(location)
    location = Location.find_or_make_by(location) unless location.class == Location
    city_state = Location.as_city_state(location)
    new(city_state, WeatherFacade.get_current_weather(city_state))
  end
end
