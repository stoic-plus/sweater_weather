require 'rails_helper'

describe FlickrFacade, type: :facade do
  describe 'class methods' do
    context '.get_background_url' do
      it 'returns photo url given location', :vcr do
        url = FlickrFacade.get_background_url("denver,co")
        expect(url).to match(/https:\/\/farm\d{1}.staticflickr.com\/\d{4}\/\w{20,22}.jpg/)
      end
    end
  end
end
