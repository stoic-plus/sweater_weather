class Api::V1::FavoritesController < Api::V1::BaseController
  def create
    api_key = params["api_key"]
    return render_api_key_error(params["api_key"]) unless api_key && User.find_by(api_key: api_key)

    add_favorite(standardize_location(params["location"]), params["api_key"])
    render json: ApiMessageSerializer.new(ApiMessage.new(message: "successfully created favorite")), status: 200
  end

  private

  def render_api_key_error(api_key)
    binding.pry
    if api_key
      render_error(message: 'invalid api_key', status: 404)
    else
      render_error(message: 'must provide api_key', status: 401)
    end
  end

  def add_favorite(city, state, api_key)
    binding.pry
    Location.create(location.split)
  end

  def standardize_location(location)
    location.gsub(" ", "").downcase.split(",")
  end
end
