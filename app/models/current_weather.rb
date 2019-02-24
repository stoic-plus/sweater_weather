class CurrentWeather < Weather
  attr_reader :time,
              :summary,
              :icon,
              :precipProbability,
              :temperature,
              :apparentTemperature,
              :humidity,
              :pressure,
              :uvIndex,
              :visibility,
              :ozone,
              :nearestStormDistance,
              :nearestStormBearing

  def initialize(attributes)
    super(
      summary: attributes[:summary],
      icon: attributes[:icon],
      precipProbability: attributes[:precipProbability],
      humidity: attributes[:humidity],
      uvIndex: attributes[:uvIndex]
    )
    @time = attributes[:time]
    @icon = attributes[:icon]
    @temperature = attributes[:temperature]
    @apparentTemperature = attributes[:apparentTemperature]
    @pressure = attributes[:pressure]
    @visibility = attributes[:visibility]
    @ozone = attributes[:ozone]
    @nearestStormDistance = attributes[:nearestStormDistance]
    @nearestStormBearing = attributes[:nearestStormBearing]
  end

  def self.for_location(coordinates)
    new(WeatherService.get_current_weather(coordinates)[:currently])
  end
end
