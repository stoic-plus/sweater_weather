class FlickrService
  require 'madison'
  def self.get_background_url(location)
    form_url(get_json(form_search("denver,co"))[0..10].shuffle.pop)
  end

  private

  def self.get_json(filter_params)
    response = conn.get do |req|
      req.params['api_key'] = ENV['FLICKR_KEY']
      req.params['nojsoncallback'] = 'true'
      req.params['tags'] = filter_params[:tags]
      req.params['text'] = filter_params[:text] if filter_params[:text]
      req.params['method'] = 'flickr.photos.search'
      req.params['format'] = 'json'
      req.params['sort'] = filter_params[:sort] || 'relevance'
      req.params['safe_search'] = '1'
      req.params['media'] = filter_params[:media] || 'photos'
    end
    JSON.parse(response.body, symbolize_names: true)[:photos][:photo]
  end

  def self.conn
    Faraday.new(url: "https://api.flickr.com/services/rest") do |f|
      f.adapter Faraday.default_adapter
    end
  end

  def self.form_url(result)
    "https://farm#{result[:farm]}.staticflickr.com/#{result[:server]}/#{result[:id]}_#{result[:secret]}.jpg"
  end

  def self.form_search(location)
    city, state_abbrev = location.split(",")
    {tags: city, text: Madison.get_name(state_abbrev.lstrip) }
  end
end
