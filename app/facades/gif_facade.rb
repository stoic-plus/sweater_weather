class GifFacade
  def self.weather_gifs(location)
    form_weather_gifs(WeatherFacade.get_daily_weather(location))
  end

  private

  def self.service
    GifService
  end

  def self.form_weather_gifs(daily_weather)
    gifs = get_gifs(daily_weather)
    daily_weather.map do |weather|
      index = gifs.find_index{|gif| gif.search_string == weather.icon}
      gif = gifs.slice!(index, 1)[0]
      WeatherGif.new(id: gif.id, time: weather.time, summary: weather.summary, gif: gif)
    end
  end

  def self.get_gifs(daily_weather)
    form_search(daily_weather).reduce([]) do |gifs, (query, amount)|
      gifs_json = service.gifs_search(query)[0...amount]
      gifs << make_gifs(gifs_json, query)
    end.flatten
  end

  def self.form_search(daily_weather)
    daily_weather.group_by {|dw| dw.icon }.reduce({}) do |icon_and_count, (icon, dw)|
      icon_and_count[icon] = dw.count
      icon_and_count
    end
  end

  def self.make_gifs(gifs_json, search_query)
    gifs_json.map do |raw_gif|
      Gif.new(raw_gif, search_query)
    end
  end
end
