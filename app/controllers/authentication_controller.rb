
require 'jwt'
class AuthenticationController < ApplicationController
    skip_before_action :authenticate_request
    def login 
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
        token = jwt_encode(user_id: @user.id)
        render json: {token: token}, status: :ok
    else
        render json: {error: 'unauthorized'}, status: :unauthorized
     end
   end
   private

  def jwt_encode(payload)
    secret_key = Rails.application.secrets.secret_key_base
    JWT.encode(payload, secret_key, 'HS256')
  end
end
