class ApiController < ApplicationController
    skip_before_action :verify_authenticity_token  
    respond_to :json

    attr_reader :current_user
    
    protected

    def show_error(status = 400, detail= "Bad request")
        {error: {status: status,detail: detail}}
    end

    def authenticate_request!
        unless user_id_in_token?
            render json: show_error(401,"Invalido accesss"), status: :unauthorized
            return
        end
        @current_user = User.find(auth_token[:user_id])
        rescue JWT::VerificationError, JWT::DecodeError
            render json: show_error(401,"Invalido accesss"), status: :unauthorized
    end
    
    private

    def http_token
        @http_token ||= if request.headers['Authorization'].present?
            request.headers['Authorization'].split(' ').last
        end
    end
  
    def auth_token
        @auth_token ||= JsonWebToken.decode(http_token)
    end
  
    def user_id_in_token?
        http_token && auth_token && auth_token[:user_id].to_i
    end

end
