class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
 
 


 # def payload
 #   auth_header = request.headers['Authorization']
    # token = auth_header.split.last
    # AuthenticationTokenService.decode(token)
  # rescue StandardError
   #  nil
   #end

  #def invalid_authentication
    #render json: { error: 'You need to login' }, status: :unauthorized
 # end
end