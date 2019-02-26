class Api::V1::GifsController < Api::V1::BaseController
  before_action :require_valid_api_key

  def show
    daily_weather = WeatherFacade.get_daily_weather(params["location"])
    weather_gifs = form_weather_gifs(daily_weather, GifService.multi_search(WeatherFacade.get_daily_icons(daily_weather)))
    render json: WeatherGifSerializer.new(weather_gifs)
  end

  private

  def form_weather_gifs(daily_weather, gifs)
    daily_weather.map do |weather|
      index = gifs.find_index{|gif| gif.search_string == weather.icon}
      gif = gifs.slice!(index, 1)[0]
      WeatherGif.new(id: gif.id, time: weather.time, summary: weather.summary, url: gif.url)
    end
  end
end
