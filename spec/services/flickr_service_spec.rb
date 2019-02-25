require 'rails_helper'

describe FlickrService, type: :service do
  describe 'class methods' do
    context '.get_background_image' do
      it 'returns flickr background image json for given location' do
        photo_json = FlickrService.get_background_image(tags: "denver", text: "Colorado")
        expect(photo_json).to be_a(Hash)
        expect(photo_json).to have_key(:id)
        expect(photo_json).to have_key(:owner)
        expect(photo_json).to have_key(:secret)
        expect(photo_json).to have_key(:server)
        expect(photo_json).to have_key(:farm)
        expect(photo_json).to have_key(:title)
      end
    end
  end
end
