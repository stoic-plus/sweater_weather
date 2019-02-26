class FlickrFacade
  require 'madison'
  def self.get_background_url(location)
    background_url = Rails.cache.read("#{location}-background")
    unless background_url
      image_json = FlickrService.get_background_image(form_search(location))
      background_url = form_url(image_json)
      Rails.cache.write("#{location}-background", background, expires_in: 1.days)
    end
    background_url
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
