class Api::V1::UsersController < Api::V1::BaseController
  include ApplicationHelper
  def create
    user = User.new(user_params)
    set_api_key(user)
    # is this JSON-API compliant?
    if user.save
      render json: ApiKeySerializer.new(ApiKey.new(user.api_key)), status: 201
    else
      render json: ApiMessageSerializer.new(ApiError.new(message: 'Incorrect Parameters')), status: 400
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def set_api_key(user)
    user.api_key = Digest::MD5.hexdigest(user.password_digest)
    user.save
  end
end
