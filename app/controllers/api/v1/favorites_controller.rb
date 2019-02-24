class Api::V1::FavoritesController < Api::V1::BaseController
  before_action :require_valid_api_key

  def index
    
  end

  def create
    add_favorite(standardize_location(params["location"]), params["api_key"])
    render json: ApiMessageSerializer.new(ApiMessage.new(message: "successfully created favorite")), status: 200
  end

  private

  def render_api_key_error(api_key)
    if api_key
      render_error(message: 'invalid api_key', status: 404)
    else
      render_error(message: 'must provide api_key', status: 401)
    end
  end

  def require_valid_api_key
    api_key = params["api_key"]
    return render_api_key_error(params["api_key"]) unless api_key && User.find_by(api_key: api_key)
  end

  def create_or_find_location(location)
    coordinates = GeocodingService.get_lat_lng("#{location[:city]},#{location[:state]}")
    Location.find_or_create_by(
      city: location[:city],
      state: location[:state],
      latitude: coordinates[:lat],
      longitude: coordinates[:lng]
    )
  end

  def add_favorite(location, api_key)
    location = create_or_find_location(location)
    User.find_by(api_key: api_key).locations << location
  end

  def standardize_location(location)
    city, state = location.gsub(" ", "").downcase.split(",")
    {city: city, state: state}
  end
end
