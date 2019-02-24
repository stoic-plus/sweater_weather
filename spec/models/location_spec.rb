require 'rails_helper'

describe Location, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
  end
  describe 'relationships' do
    it { should have_many :favorites }
    it { should have_many(:users).through(:favorites) }
  end
end
