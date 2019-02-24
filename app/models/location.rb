class Location < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites

  validates_presence_of :city, :state, :latitude, :longitude

  def self.find_or_make_by(location)
    city_state = standardize_location(location)
    coordinates = GeocodingService.get_lat_lng("#{city_state[:city]},#{city_state[:state]}")
    find_or_create_by(
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
