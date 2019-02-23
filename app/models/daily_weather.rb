class DailyWeather
  attr_reader :time,
              :summary,
              :icon,
              :precipProbability,
              :precipType,
              :temperatureHigh,
              :temperatureLow,
              :apparentTemperatureHigh,
              :apparentTemperatureLow,
              :humidity,
              :uvIndex,
              :temperatureMin,
              :temperatureMax,
              :apparentTemperatureMax,
              :apparentTemperatureMin

  def initialize(attributes)
    @time = attributes[:time]
    @summary = attributes[:summary]
    @icon = attributes[:icon]
    @precipProbability = attributes[:precipProbability]
    @precipType = attributes[:precipType]
    @temperatureHigh = attributes[:temperatureHigh]
    @temperatureLow = attributes[:temperatureLow]
    @apparentTemperatureHigh = attributes[:apparentTemperatureHigh]
    @apparentTemperatureLow = attributes[:apparentTemperatureLow]
    @humidity = attributes[:humidity]
    @uvIndex = attributes[:uvIndex]
    @temperatureMin = attributes[:temperatureMin]
    @temperatureMax = attributes[:temperatureMax]
    @apparentTemperatureMax = attributes[:apparentTemperatureMax]
    @apparentTemperatureMin = attributes[:apparentTemperatureMin]
  end
end
