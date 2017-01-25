module ApiFlashcards
  class HomeController < ApplicationController
    def index
      render plain: "You can see me!"
    end
  end
end
