class HourlyWeather < Weather
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
      attributes[:summary],
      attributes[:icon],
      attributes[:precipProbability],
      attributes[:humidity],
      attributes[:uvIndex]
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
end
