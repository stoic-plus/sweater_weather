require 'rails_helper'

describe WeatherFacade, type: :facade do
  let(:facade) { WeatherFacade }
  describe 'class methods' do
    context '.get_forecast' do
      it 'returns Forecast Object with appropriate methods and Weather Objects - given valid city,state' do
        forecast = facade.get_forecast("denver,co")

        currently = forecast.currently
        hourlies = forecast.hourly
        dailies = forecast.daily

        expect(currently).to be_a(Weather)
        expect(hourlies).to all(be_a(Weather))
        expect(hourlies.count).to eq(48)
        expect(dailies).to all(be_a(Weather))
        expect(dailies.count).to eq(8)

        expect(forecast.today_high).to eq(dailies.first.temperatureHigh)
        expect(forecast.today_low).to eq(dailies.first.temperatureLow)
        expect(forecast).to respond_to(:today_summary)
        expect(forecast.tonight_summary).to eq(dailies.first.summary)
      end
    end
  end
end
