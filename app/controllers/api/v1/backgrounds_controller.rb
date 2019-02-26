class Api::V1::BackgroundsController < Api::V1::BaseController
  def show
    background_url = FlickrFacade.get_background_url(params["location"])
    background = Background.new(params["location"], background_url)
    render json: BackgroundSerializer.new(background)
  end
end
