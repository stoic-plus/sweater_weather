class Api::V1::GifsController < Api::V1::BaseController
  before_action :require_valid_api_key

  def show
    
  end

  def require_valid_api_key
    api_key = params["api_key"]
    render_api_key_error(params["api_key"]) unless api_key && User.find_by(api_key: api_key)
  end
end
