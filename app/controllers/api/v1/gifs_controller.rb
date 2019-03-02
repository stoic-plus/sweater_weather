class Api::V1::GifsController < Api::V1::BaseController
  def show
    render json: WeatherGifSerializer.new(GifFacade.weather_gifs(params["location"]))
  end
end
