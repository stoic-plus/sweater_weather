class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :location

  def self.destroy_favorite(api_key, location)
    user_id = User.find_by(api_key: api_key).id
    city, state = location.split(",")
    location_id = Location.find_by(city: city.downcase, state: state.downcase)
    find_by(user_id: user_id, location_id: location_id).destroy
  end
end
