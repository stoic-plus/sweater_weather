class Api::V1::BaseController < ApplicationController
  include ApplicationHelper
  def render_error(attributes)
    render json: ApiMessageSerializer.new(ApiError.new(message: attributes[:message])), status: attributes[:status]
  end
end
