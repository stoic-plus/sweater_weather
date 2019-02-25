class GifService
  def self.search_for_gifs(search_string)
    gifs = get_search_json(search_string)
    gifs.map do |raw_gif|
      Gif.new(raw_gif, search_string)
    end
  end

  def self.multi_search(query_and_times)
    query_and_times.reduce([]) do |gifs, (query, times)|
      gifs << search_for_gifs(query)[0...times]
    end.flatten
  end

  private

  def self.get_search_json(query, limit=nil)
    response = conn.get do |req|
      req.url '/v1/gifs/search'
      req.params['api_key'] = ENV['GIPHY_KEY']
      req.params['q'] = query
      req.params['limit'] = limit if limit
    end
    JSON.parse(response.body, symbolize_names: true)[:data]
  end

  def self.conn
    Faraday.new(url: "https://api.giphy.com") do |f|
      f.adapter  Faraday.default_adapter
    end
  end
end
