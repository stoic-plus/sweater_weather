class Api::V1::ForecastController < ApplicationController
  def show
    render json: Api::V1::ForecastSerializer.new(WeatherFacade.get_forecast(params["location"]))
  end
end
