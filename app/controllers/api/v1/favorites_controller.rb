class Api::V1::FavoritesController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token
  before_action :require_valid_api_key

  def index
    render json: FavoritesSerializer.new(User.get_favorites_for(api_key: params["api_key"])), status: 200
  end

  def create
    location = Location.find_or_make_by(params["location"])
    User.find_by(api_key: params["api_key"]).locations << location
    render json: ApiMessageSerializer.new(favorite_response(location, :created)), status: 201
  end

  def destroy
    Favorite.destroy_favorite(params["api_key"], params["location"])
    render json: ApiMessageSerializer.new(favorite_response(params["location"], :destroyed)), status: 202
  end

  private

  def favorite_response(location, action)
    message = action == :created ? "successfully created favorite" : "successfully deleted favorite"
    FavoritesMessage.new(message: message, favorite: FavoriteWeather.from_location(location))
  end
end
