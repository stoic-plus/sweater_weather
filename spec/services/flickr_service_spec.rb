require 'rails_helper'

describe FlickrService, type: :service do
  describe 'class methods' do
    context '.get_background' do
      it 'returns flickr background image url for given location' do
        photo_url = FlickrService.get_background_url("denver,co")
        expect(photo_url).to match(/https:\/\/farm\d{1}.staticflickr.com\/\d{4}\/\w{22}.jpg/)
      end
    end
  end
end
