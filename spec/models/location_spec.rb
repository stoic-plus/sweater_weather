require 'rails_helper'

describe Location, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
  end
  describe 'relationships' do
    it { should have_many(:favorites).dependent(:destroy) }
    it { should have_many(:users).through(:favorites) }
  end
  describe 'class methods' do
    let(:location) { instance_double('Location') }
    context '.as_city_state' do
      it 'returns location row as string of (City, STATE_ABREV) given location row' do
        allow(location).to receive_message_chain(:city, :capitalize).and_return("Denver")
        allow(location).to receive(:class).and_return(Location)
        allow(location).to receive_message_chain(:state, :upcase).and_return("CO")

        expect(Location.as_city_state(location)).to eq("Denver,CO")
      end
      it 'returns location string with spaces removed given string' do
        location_string = "Denver, CO"
        expect(Location.as_city_state(location_string)).to eq("Denver,CO")
      end
    end
  end
end
