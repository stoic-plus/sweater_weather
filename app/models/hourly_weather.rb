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
              :ozone

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
  end
end
