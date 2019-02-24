class Location < ApplicationRecord
  has_many :favorites
  has_many :users, through: :favorites

  validates_presence_of :city, :state, :latitude, :longitude
end
