class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params["email"])

    if user && user.authenticate(params["password"])
      render json: { status: 200, api_key: user.api_key }, status: 200
    else
      render json: { status: 400, message: 'Incorrect Login Information' }, status: 400
    end
  end
end
