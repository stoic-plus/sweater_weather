class HourlyWeather
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
    @time = attributes[:time]
    @summary = attributes[:summary]
    @icon = attributes[:icon]
    @precipProbability = attributes[:precipProbability]
    @temperature = attributes[:temperature]
    @apparentTemperature = attributes[:apparentTemperature]
    @humidity = attributes[:humidity]
    @pressure = attributes[:pressure]
    @uvIndex = attributes[:uvIndex]
    @visibility = attributes[:visibility]
    @ozone = attributes[:ozone]
    @nearestStormDistance = attributes[:nearestStormDistance]
    @nearestStormBearing = attributes[:nearestStormBearing]
  end
end
