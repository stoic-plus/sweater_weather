class BackgroundSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :location, :photo_url
end
