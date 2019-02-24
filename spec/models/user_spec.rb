require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it { should have_secure_password }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_confirmation).on(:create) }
  end
  describe 'relationships' do
    it { should have_many :favorites }
    it { should have_many(:locations).through(:favorites)}
  end
end
