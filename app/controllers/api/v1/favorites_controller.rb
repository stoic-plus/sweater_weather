class Api::V1::FavoritesController < Api::V1::BaseController
  before_action :require_valid_api_key

  def index
    render json: FavoritesSerializer.new(User.get_favorites_for(api_key: params["api_key"])), status: 200
  end

  def create
    User.find_by(api_key: params["api_key"]).locations << Location.find_or_make_by(params["location"])
    render json: ApiMessageSerializer.new(ApiMessage.new(message: "successfully created favorite")), status: 200
  end

  def destroy
    favorites = User.get_favorites_for(api_key: params["api_key"])
    Favorite.destroy_favorite(params["api_key"], params["location"])
    render json: FavoritesSerializer.new(favorites), status: 200
  end
end
