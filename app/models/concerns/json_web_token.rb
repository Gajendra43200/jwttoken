require 'jwt'
module JsonWebToken
    extend ActiveSupport::Concern
    SECRET_KEY = Rails.application.secret_key_base
    def jwt_encode(payload, exp = 7.days.from_now)
        payload[:exp] = :exp.to_i
        JWT_encode(payload, SECRET_KEY)
    end
    def decode(token)
        decoded = JWT.decode(token, SECRET_KEY)[0]
        HashWithIndifferentAccess.now decoded 
    end 
    
end