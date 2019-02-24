class Api::V1::FavoritesController < Api::V1::BaseController
  before_action :require_valid_api_key

  def index
    favorites = User.find_by(api_key: params["api_key"]).get_favorites
    render json: FavoritesSerializer.new(favorites), status: 200
  end

  def create
    User.find_by(api_key: params["api_key"]).locations << Location.find_or_make_by(params["location"])
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
    render_api_key_error(params["api_key"]) unless api_key && User.find_by(api_key: api_key)
  end
end
