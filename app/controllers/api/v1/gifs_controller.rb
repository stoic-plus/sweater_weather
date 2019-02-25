class Api::V1::GifsController < Api::V1::BaseController
  before_action :require_valid_api_key

  def show
    daily_weather = WeatherFacade.get_daily_weather(params["location"])
    form_weather_gifs(daily_weather, GifService.multi_search(WeatherFacade.get_daily_icons(daily_weather)))
  end

  def require_valid_api_key
    api_key = params["api_key"]
    render_api_key_error(params["api_key"]) unless api_key && User.find_by(api_key: api_key)
  end

  private

  def form_weather_gifs(daily_weather, gifs)
    daily_weather.map do |weather|
      index = gifs.find_index{|gif| gif.search_string == weather.icon}
      gif = gifs.slice!(index, 1)
      WeatherGif.new(time: weather.time, summary: weather.summary, url: gif.url)
    end
  end
end
