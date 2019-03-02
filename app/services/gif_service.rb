class GifService
  def self.gifs_search(query, limit=nil)
    response = conn.get do |req|
      req.url '/v1/gifs/search'
      req.params['api_key'] = ENV['GIPHY_KEY']
      req.params['q'] = query
      req.params['limit'] = limit if limit
    end
    JSON.parse(response.body, symbolize_names: true)[:data]
  end

  private

  def self.conn
    Faraday.new(url: "https://api.giphy.com") do |f|
      f.adapter  Faraday.default_adapter
    end
  end
end
