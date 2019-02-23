class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    # is this JSON-API compliant?
    if user.save
      render json: { status: 201, api_key: Digest::MD5.hexdigest(user.password_digest) }, status: 201
    else
      render json: { status: 400, message: 'Incorrect Parameters' }, status: 400
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end