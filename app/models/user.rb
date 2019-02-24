class User < ApplicationRecord
  has_secure_password
  has_many :favorites
  has_many :locations, through: :favorites

  validates_presence_of :email, :password
  validates :password_confirmation, presence: true, on: :create

  def get_favorites
    locations.map do |location|
      current_weather = CurrentWeather.for_location(lat: location.latitude, lng: location.longitude)
      location = "#{location.city.capitalize} #{location.state.upcase}"
      FavoriteWeather.new(location, current_weather)
    end
  end
end
