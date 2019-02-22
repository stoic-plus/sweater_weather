require 'rails_helper'

describe GeocodingService, type: :service do
  let(:service) { GeocodingService }
  describe 'class methods' do
    context '.get_lat_lng' do
      it 'retrieves latitude and longitude given city state' do
        coordinates = service.get_lat_lng("denver,co")

        expect(coordinates["lat"]).to eq(39.7392358)
        expect(coordinates["lng"]).to eq(-104.990251)
      end
      it 'retrieves latitude and longitude given street address' do
        coordinates = service.get_lat_lng("1331 17th St LL100, Denver, CO 80202")

        expect(coordinates["lat"]).to eq(39.7508006)
        expect(coordinates["lng"]).to eq(-104.9965947)
      end
    end
  end
end
