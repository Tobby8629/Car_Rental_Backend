class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

  def authenticate_request!
    return invalid_authentication if !payload || !AuthenticationTokenService.valid_payload(payload.first)

    current_user!
    invalid_authentication unless @current_user
  end

  def current_user!
    if payload && AuthenticationTokenService.valid_payload(payload.first)
      user_id = payload.first['user_id']
      @current_user = User.find_by(id: user_id)
    else
      @current_user = User.new(id: -1) # Assign a default ID value, such as -1
    end
  end
  

  private

  def payload
    auth_header = request.headers['Authorization']
    token = auth_header.split.last
    AuthenticationTokenService.decode(token)
  rescue StandardError
    nil
  end

  def invalid_authentication
    render json: { error: 'You need to login' }, status: :unauthorized
  end
end