class ApplicationController < ActionController::API
    before_action :authenticate_request
    private
    def authenticate_request 
    header = request.headers["Authorizatin"]
    header = header.split(" ").last if header
    decoded = jwt_encode(header)
    @current_user = User.find(decoded[:user_id])
    end
end
