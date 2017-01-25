module ApiFlashcards
  module Api::V1
    class CardsController < ApplicationController

      #api :GET, '/api/v1', 'Returns all user cards'
      #error :code => 401, :desc => "Unauthorized"
      def index
        @cards = @user.cards.order('review_date')

        render json: @cards
      end

      #api :GET, '/v1/cards/:id', 'Show card'
      #error :code => 401, :desc => "Unauthorized"
      def show
        @card = Card.find(params[:id])
        render json: @card
      end

      #api :POST, '/v1/cards', 'Creates new card'
      #param :original_text, :translated_text, :review_date
      #error :code => 400, :desc => "Wrong params: blank text"
      #error :code => 401, :desc => "Unauthorized"
      def create
        @card = @user.cards.build(card_params)

        if @card.save
          render json: @card
        else
          render json: { errors: @card.errors }, status: 400
        end
      end

      #api :POST, '/v1/cards', 'Check Translate card'
      #param :card_id, :user_translation
      #error :code => 401, :desc => "Unauthorized"
      def review
        @card = @user.cards.find(card_review_params[:card_id])
        check = CheckTranslate.new

        render json: check.call(@card, card_review_params[:user_translation])
      end

      private

      def card_params
        params[:card].permit(:original_text, :translated_text, :review_date)
      end

      def card_review_params
        params.permit(:card_id, :user_translation)
      end
    end
  end
end
