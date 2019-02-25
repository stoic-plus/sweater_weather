class FlickrFacade
  require 'madison'
  def self.get_background_url(location)
    image_json = FlickrService.get_background_image(form_search(location))
    form_url(image_json)
  end

  private

  def self.form_url(result)
    "https://farm#{result[:farm]}.staticflickr.com/#{result[:server]}/#{result[:id]}_#{result[:secret]}.jpg"
  end

  def self.form_search(location)
    city, state_abbrev = location.split(",")
    {tags: city, text: Madison.get_name(state_abbrev.lstrip) }
  end
end
