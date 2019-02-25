class WeatherGif
  def initialize(attributes)
    @time = attributes[:time]
    @summary = attributes[:summary]
    @url = attributes[:url]
  end
end
