require 'rails_helper'

describe Forecast, type: :model do
  xit 'can be initialized with weather data', :vcr do
    # weather_data = WeatherService.get_forecast("denver,co")
    forecast = Forecast.new(weather_data)
  end
  describe 'class methods' do
    context '' do

    end
  end
end
