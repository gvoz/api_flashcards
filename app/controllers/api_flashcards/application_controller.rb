module ApiFlashcards
  class ApplicationController < ActionController::Base

    protected
      def request_confirm
        authenticate_or_request_with_http_basic do |user, password|
          user == "admin" && password == "secret"
        end
      end
  end
end
