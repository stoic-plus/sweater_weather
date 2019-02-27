require 'rails_helper'

describe WeatherFacade, type: :facade do
  include ApplicationHelper::WeatherMethods
  let(:facade) { WeatherFacade }
  describe 'class methods' do
    context '.get_forecast' do
      it 'returns Forecast Object with appropriate methods and Weather Objects - given valid city,state', :vcr do
        allow(Cache).to receive(:read_forecast).and_return(nil)
        allow(Cache).to receive(:write_forecast)

        expect(WeatherService).to receive(:get_forecast).and_return(forecast_json)

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
        expect(WeatherService).to receive(:get_daily_weather).and_return(daily_json)
        first_day_json = daily_json[:daily][:data].first
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
    context '.get_daily_icons' do
      it 'retrieves icons, and count of icon by getting daily weather', :vcr do
        daily_weather = DailyWeather.from_weather_data(daily_json[:daily][:data])
        allow(facade).to receive(:get_daily_weather).and_return(daily_weather)
        descriptions = facade.get_daily_icons(nil, "denver,co")

        expect(descriptions.first[0]).to be_a(String)
        expect(descriptions.first[1]).to be_a(Integer)
      end
      it 'retrieves icons, and count of icon given daily weather array' do
        daily_weather = DailyWeather.from_weather_data(daily_json[:daily][:data])
        expect(facade).not_to receive(:get_daily_weather)
        descriptions = facade.get_daily_icons(daily_weather)

        expect(descriptions.first[0]).to be_a(String)
        expect(descriptions.first[1]).to be_a(Integer)
      end
    end
  end
end
