class Api::V1::ForecastController < Api::V1::BaseController
  def show
    render json: ForecastSerializer.new(WeatherFacade.get_forecast(params["location"]))
  end
end
