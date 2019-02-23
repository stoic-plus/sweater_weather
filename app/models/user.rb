class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email, :password
  validates :password_confirmation, presence: true, on: :create
end
