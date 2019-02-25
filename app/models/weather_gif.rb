class WeatherGif
  attr_reader :id, :time, :summary, :url
  def initialize(attributes)
    @id = attributes[:id]
    @time = attributes[:time]
    @summary = attributes[:summary]
    @url = attributes[:url]
  end
end
