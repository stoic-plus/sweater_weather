class Gif
  attr_reader :search_string, :embed_url, :looping, :original_url
  def initialize(attributes, search_string)
    @search_string = search_string
    @embed_url = attributes[:embed_url]
    @looping = attributes[:images][:looping][:mp4]
    @original_url = attributes[:images][:original][:url]
  end
end
