module ApiFlashcards
  class ApplicationController < ActionController::Base
    attr_reader :current_user

    protected

      def request_confirm
        authenticate_or_request_with_http_basic do |user, password|
          user = User.find_by(email: email)
          if user && user.password == password
            @current_user = user
          else
            render json: { message: "Authentication failed" }, status: 401
          end
        end
      end
  end
end
