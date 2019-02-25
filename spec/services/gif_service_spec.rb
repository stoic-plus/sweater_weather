require 'rails_helper'

describe GifService, type: :service do
  describe 'class methods' do
    context '.search_for_gifs' do
      it 'returns an array of gif objects given search' do
        gifs = GifService.search_for_gifs("partly+cloudy")

        expect(gifs).to all(be_a(Gif))
        expect(gifs.first.url).to match(match(/https:\/\/giphy.com\/gifs\/\w+/))
      end
    end
  end
end
