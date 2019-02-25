require 'rails_helper'

conn =  Faraday.new(url: "https://api.flickr.com/services/rest") do |f|
    f.adapter Faraday.default_adapter
  end
  
response = conn.get do |req|
  req.params['api_key'] = '31d04d75a89e55757727b26f428fc380'
  req.params['nojsoncallback'] = 'true'
  req.params['tags'] = 'austin,tx'
  req.params['text'] = 'denver'
  req.params['method'] = 'flickr.photos.search'
  req.params['format'] = 'json'
  req.params['sort'] = 'relevance'
  req.params['safe_search'] = '1'
  req.params['media'] = 'photos'
end

conn2 = Faraday.new(url: "https://farm5.staticflickr.com/4399/36603326720_509f5ec5d3.jpg")


binding.pry
