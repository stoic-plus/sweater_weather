class Api::V1::SessionsController < ApplicationController
  include ApplicationHelper
  def create
    user = User.find_by(email: params["email"])

    if user && user.authenticate(params["password"])
      render json: ApiKeySerializer.new(ApiKey.new(user.api_key)), status: 200
    else
      render json: ApiErrorSerializer.new(ApiError.new(message: 'Incorrect Login Information')), status: 400
    end
  end
end
