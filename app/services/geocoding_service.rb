class GeocodingService
  def self.get_lat_lng(address)
    clean_address = address.gsub(" ", "+")
    get_gecode_json(clean_address)[:geometry][:location]
  end

  private

  def self.get_gecode_json(address)
    response = conn.get do |req|
      req.params['address'] = address.gsub(" ", "+")
      req.params["key"] = ENV['GOOGLE_KEY']
    end
    JSON.parse(response.body, symbolize_names: true)[:results][0]
  end

  def self.conn
    Faraday.new(url: "https://maps.googleapis.com/maps/api/geocode/json")
  end
end
