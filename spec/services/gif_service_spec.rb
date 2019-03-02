require 'rails_helper'

describe GifService, type: :service do
  describe 'class methods' do
    context '.search_for_gifs' do
      it 'returns an array of gif objects given search', :vcr do
        gifs = GifService.gifs_search("partly+cloudy")

        gifs.each do |gif|
          expect(gif).to have_key(:id)
          expect(gif).to have_key(:url)
          expect(gif).to have_key(:images)
          expect(gif).to have_key(:embed_url)
          expect(gif).to have_key(:slug)
        end
      end
    end
  end
end
