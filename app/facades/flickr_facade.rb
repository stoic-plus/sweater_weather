class FlickrFacade
  require 'madison'
  def self.get_background_url(location)
    background_url = Cache.read_background(location)
    unless background_url
      background_url = form_url(get_image_json(location))
      Cache.write_background(location, background_url)
    end
    background_url
  end

  private

  def self.get_image_json(location)
    FlickrService.get_background_image(form_search(location))
  end

  def self.form_url(result)
    "https://farm#{result[:farm]}.staticflickr.com/#{result[:server]}/#{result[:id]}_#{result[:secret]}.jpg"
  end

  def self.form_search(location)
    city, state_abbrev = location.split(",")
    {tags: city, text: Madison.get_name(state_abbrev.lstrip) }
  end
end
