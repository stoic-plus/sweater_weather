class FlickrService
  require 'madison'
  def self.get_background_image(filter_params)
    get_photos_json(filter_params)[0..10].shuffle.pop
  end

  private

  def self.get_photos_json(filter_params)
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
end
