class WeatherGif
  attr_reader :id, :time, :summary, :gif
  def initialize(attributes)
    @id = attributes[:id]
    @time = attributes[:time]
    @summary = attributes[:summary]
    @gif = attributes[:gif]
  end
end
