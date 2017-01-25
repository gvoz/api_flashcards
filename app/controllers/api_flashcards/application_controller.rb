module ApiFlashcards
  class ApplicationController < ActionController::Base
    attr_reader :user
    before_action :request_confirm

    protected

      def request_confirm
        authenticate_or_request_with_http_basic do |email, password|
          user = User.find_by(email: email)
          if user && user.password == password
            @user = user
          else
            render json: { message: "Authentication failed" }, status: 401
          end
        end
      end
  end
end
