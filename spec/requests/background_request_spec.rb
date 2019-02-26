require 'rails_helper'

describe 'Background Image Request', type: :request do
  context 'when making a GET req to /api/v1/backgrounds with valid location param' do
    it 'returns a photo url for the location', :vcr do
      get '/api/v1/backgrounds', params: {location: "denver,co"}

      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)["data"]["attributes"]
      expect(json).to have_key("location")
      expect(json).to have_key("photo_url")
    end
    it 'does not make api call if background in cache' do
      Rails.cache.write("denver,co-background", "https://farm8.staticflickr.com/7662/16497776394_2ea733dd23.jpg", expires_in: 1.days)
      expect(FlickrFacade).not_to receive(:get_background_url)

      travel 18.hours
      
      get '/api/v1/backgrounds', params: {location: "denver,co"}

      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)["data"]["attributes"]
      expect(json).to have_key("location")
      expect(json).to have_key("photo_url")
    end
  end
end
