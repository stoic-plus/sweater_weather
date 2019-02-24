require 'rails_helper'

describe WeatherFacade, type: :facade do
  let(:facade) { WeatherFacade }
  describe 'class methods' do
    context '.get_forecast' do
      it 'returns Forecast Object with appropriate methods and Weather Objects - given valid city,state', :vcr do
        forecast = facade.get_forecast("denver,co")

        expect(forecast).to be_a(Forecast)
        currently = forecast.currently
        hourlies = forecast.hourly_forecast
        dailies = forecast.daily_forecast

        expect(currently).to be_a(CurrentWeather)
        expect(hourlies).to all(be_a(HourlyWeather))
        expect(hourlies.count).to eq(49)
        expect(dailies).to all(be_a(DailyWeather))
        expect(dailies.count).to eq(8)

        expect(forecast.today_high).to eq(dailies.first.temperatureHigh)
        expect(forecast.today_low).to eq(dailies.first.temperatureLow)
        expect(forecast).to respond_to(:today_summary)
        expect(forecast.tonight_summary).to eq(dailies.first.summary)
      end
    end
  end
end
