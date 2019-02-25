class WeatherService
  def self.get_forecast(coordinates)
    get_json(coordinates[:lat], coordinates[:lng], 'minutely,alerts,flags')
  end

  def self.get_current_weather(coordinates)
    get_json(coordinates[:lat], coordinates[:lng], 'minutely,hourly,daily,alerts,flags')
  end

  def self.get_daily_weather(coordinates)
    get_json(coordinates[:lat], coordinates[:lng], 'currently,minutely,hourly,alerts,flags')
  end

  private

  def self.get_json(lat,lng,exclude=nil)
    response = conn(lat,lng).get do |req|
      req.params['exclude'] = exclude if exclude
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn(lat,lng)
    Faraday.new(url: "https://api.darksky.net/forecast/#{ENV['DARK_SKY_SECRET_KEY']}/#{lat},#{lng}")
  end
end
