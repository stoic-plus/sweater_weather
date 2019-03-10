class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token
  def create
    user = User.find_by(email: params["email"])

    if user && user.authenticate(params["password"])
      render json: SessionsSerializer.new(Users.new(user.api_key)), status: 200
    else
      render json: ApiMessageSerializer.new(ApiError.new(message: 'Incorrect Login Information')), status: 400
    end
  end
end
