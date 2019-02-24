require 'rails_helper'

describe FlickrService, type: :service do
  describe 'class methods' do
    context '.get_background' do
      it 'returns flickr background image url for given location' do
        photo_url = FlickrService.get_background("denver,co")

        expect(photo_url).to match(/https:\/\/farm\d{1}.staticflickr.com\/\d{1}\/\d{7}_\w{10}.jpg/)
      end
    end
  end
end
