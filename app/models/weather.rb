class Weather
  attr_reader :summary,
              :icon,
              :precipProbability,
              :humidity,
              :uvIndex

  def initialize(attributes)
    @summary = attributes[:summary]
    @icon = attributes[:icon]
    @precipProbability = attributes[:precipProbability]
    @humidity = attributes[:humidity]
    @uvIndex = attributes[:uvIndex]
  end
end
