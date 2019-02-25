require 'rails_helper'

describe 'Background Image Request', type: :request do
  context 'when making a GET req to /api/v1/backgrounds with valid location param' do
    it 'returns a photo url for the location' do
      get '/api/v1/backgrounds', params: {location: "denver,co"}

      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)["attributes"]
      expect(json).to have_key("photo_url")
    end
  end
end
