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
    context '.get_daily_weather' do
      it 'returns DailyWeather objects for given location', :vcr do
        daily_weather_json = WeatherService.get_daily_weather(lat: "39.7392358", lng: "-104.990251")
        first_day_json = daily_weather_json[:daily][:data].first
        daily_weathers = facade.get_daily_weather("denver, co")

        expect(daily_weathers).to all(be_a(DailyWeather))
        first_day = daily_weathers.first

        expect(first_day.time).to eq(first_day_json[:time])
        expect(first_day.summary).to eq(first_day_json[:summary])
        expect(first_day.icon).to eq(first_day_json[:icon])
        expect(first_day.precipType).to eq(first_day_json[:precipType])
        expect(first_day.temperatureHigh).to eq(first_day_json[:temperatureHigh])
        expect(first_day.temperatureLow).to eq(first_day_json[:temperatureLow])
        expect(first_day.apparentTemperatureHigh).to eq(first_day_json[:apparentTemperatureHigh])
        expect(first_day.apparentTemperatureLow).to eq(first_day_json[:apparentTemperatureLow])
        expect(first_day.temperatureMin).to eq(first_day_json[:temperatureMin])
        expect(first_day.temperatureMax).to eq(first_day_json[:temperatureMax])
      end
    end
    context '.get_daily_descriptions' do
      it 'retrieves sumarries, icons, and times given daily weather array', :vcr do
        daily_weathers = facade.get_daily_weather("denver, co")
        descriptions = facade.get_daily_descriptions(daily_weathers)

        expect(descriptions.first).to have_key(:summary)
        expect(descriptions.first).to have_key(:icon)
        expect(descriptions.first).to have_key(:count)
      end
    end
  end
end
