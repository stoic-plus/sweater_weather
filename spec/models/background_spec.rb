require 'rails_helper'

describe Background, type: :model do
  it 'can be initialized with attributes', :vcr do
    location = "sandiego,ca"
    photo_url = FlickrFacade.get_background_url(location)

    background = Background.new(location, photo_url)
    expect(background.location).to eq(location)
    expect(background.photo_url).to eq(photo_urls)
  end
end
