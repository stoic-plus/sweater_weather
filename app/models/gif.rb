class Gif
  attr_reader :id, :url, :search_string
  def initialize(attributes, search_string)
    @search_string = search_string
    @id = attributes[:id]
    @url = attributes[:url]
  end
end
