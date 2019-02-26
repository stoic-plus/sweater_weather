class Location < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites

  validates_presence_of :city, :state, :latitude, :longitude

  def self.find_or_make_by(location)
    location = find_by(standardize_location(location))
    return location if location
    coordinates = GeocodingService.get_lat_lng("#{city_state[:city]},#{city_state[:state]}")
    create(
      city: city_state[:city],
      state: city_state[:state],
      latitude: coordinates[:lat],
      longitude: coordinates[:lng]
    )
  end

  private

  def self.standardize_location(location)
    city, state = location.gsub(" ", "").downcase.split(",")
    {city: city, state: state}
  end
end
