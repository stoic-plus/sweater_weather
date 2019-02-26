class Api::V1::BaseController < ApplicationController
  include ApplicationHelper

  def render_error(attributes)
    render json: ApiMessageSerializer.new(ApiError.new(message: attributes[:message])), status: attributes[:status]
  end

  private

  def require_valid_api_key
    api_key = params["api_key"]
    render_api_key_error(params["api_key"]) unless api_key && User.find_by(api_key: api_key)
  end
    
  def render_api_key_error(api_key)
    if api_key
      render_error(message: 'invalid api_key', status: 404)
    else
      render_error(message: 'must provide api_key', status: 401)
    end
  end
end
