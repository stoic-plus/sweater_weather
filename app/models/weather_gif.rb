class WeatherGif
  attr_reader :id, :time, :summary, :gif
  @@count = 0
  def initialize(attributes)
    @id = @@count
    @@count += 1
    @time = attributes[:time]
    @summary = attributes[:summary]
    @gif = attributes[:gif]
  end
end
