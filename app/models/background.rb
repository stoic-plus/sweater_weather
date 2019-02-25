class Background
  attr_reader :location,
              :photo_url,
              :id
              
  @@count = 0
  def initialize(location, photo_url)
    @id = @@count
    @@count += 1
    @location = location
    @photo_url = photo_url
  end
end
