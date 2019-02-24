class DailyWeather < Weather
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
    super(
      summary: attributes[:summary],
      icon: attributes[:icon],
      precipProbability: attributes[:precipProbability],
      humidity: attributes[:humidity],
      uvIndex: attributes[:uvIndex])
    @time = attributes[:time]
    @precipType = attributes[:precipType]
    @temperatureHigh = attributes[:temperatureHigh]
    @temperatureLow = attributes[:temperatureLow]
    @apparentTemperatureHigh = attributes[:apparentTemperatureHigh]
    @apparentTemperatureLow = attributes[:apparentTemperatureLow]
    @temperatureMin = attributes[:temperatureMin]
    @temperatureMax = attributes[:temperatureMax]
    @apparentTemperatureMax = attributes[:apparentTemperatureMax]
    @apparentTemperatureMin = attributes[:apparentTemperatureMin]
  end
end
