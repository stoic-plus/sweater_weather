class User < ApplicationRecord
  has_secure_password
  has_many :favorites
  has_many :locations, through: :favorites

  validates_presence_of :email, :password
  validates :password_confirmation, presence: true, on: :create

  def self.get_favorites_for(user_attributes)
    find_by(user_attributes).get_favorites
  end

  def get_favorites
    locations.map do |location|
      city_state = Location.as_city_state(location)
      current_weather = CurrentWeather.for_location(
        location: city_state,
        lat: location.latitude,
        lng: location.longitude
      )
      FavoriteWeather.new(city_state, current_weather)
    end
  end

  def set_api_key
    self.api_key = Digest::MD5.hexdigest(password_digest)
    save
  end
end
