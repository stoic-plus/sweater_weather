class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token

  def create
    user = User.new(user_params)
    if user.save
      user.set_api_key
      render json: UsersSerializer.new(Users.new(user.api_key)), status: 201
    else
      render json: ApiMessageSerializer.new(ApiError.new(message: 'Incorrect Parameters')), status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
