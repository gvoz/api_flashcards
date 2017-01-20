module ApiFlashcards
  class HomeController < ApplicationController
    before_action :request_confirm

    def index
      render plain: "You can see me!"
    end
  end
end
