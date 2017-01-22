module ApiFlashcards
  module Api::V1
    class CardsController < ApplicationController
      before_action :request_confirm

      def index
        @cards = @user.cards.order('review_date')

        render json: @cards
      end

      def show
        @card = Card.find(params[:id])
        render json: @card
      end

      def create
        @card = @user.cards.build(card_params)

        if @card.save
          render json: @card
        else
          render json: { errors: @post.errors }
        end
      end

      def review
        @card = @user.cards.find(card_review_params[:card_id])

        render json: CheckTranslate.new(@card, card_review_params[:user_translation]).call
      end

      private

      def card_params
        params.permit(:original_text, :translated_text, :review_date, :block_id)
      end

      def card_review_params
        params.permit(:card_id, :user_translation)
      end
    end
  end
end
