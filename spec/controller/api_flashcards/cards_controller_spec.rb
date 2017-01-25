require 'rails_helper'
require 'support/authentication_helper.rb'

module ApiFlashcards
  module Api::V1
    describe CardsController, type: :controller do
      routes { ApiFlashcards::Engine.routes }

      let!(:user) { create(:user) }

      describe "get list user's cards" do
        let!(:cards) { create_list(:card, 3, user: user) }

        before :each do
          authentication(user.email, user.password)
          get :index
        end

        it 'status ok' do
          expect(response).to have_http_status(:ok)
        end

        it 'have 3 cards' do
          list = JSON.parse(response.body)
          expect(list.size).to eq 3
        end
      end

      describe "Create user's cards" do

        before :each do
          authentication(user.email, user.password)
          get :index
        end

        it 'success' do
          card_params = {
            'original_text': 'Test',
            'translated_text': 'тест'
          }
          post :create, card: card_params
          expect(response).to have_http_status(:ok)
          expect(user.cards.first.original_text).to eq 'Test'
        end

        it 'error' do
          card_params = {
            'original_text': 'Test',
            'translated_text': ''
          }
          post :create, card: card_params
          expect(response.status).to eq 400
        end
      end

      describe "Show user's cards" do
        let!(:card) { create(:card, user: user) }

        before :each do
          authentication(user.email, user.password)
          get :index
        end

        it 'success' do
          card_id = user.cards.first.id
          get :show, { id: card_id }
          response_message = JSON.parse(response.body)
          expect(response_message['id']).to eq 1
        end
      end

      describe "Review user's cards" do
        let!(:card) { create(:card, user: user) }

        before :each do
          authentication(user.email, user.password)
          get :index
        end

        it 'success' do
          card_id = user.cards.first.id
          post :review, { card_id: card_id, user_translation: "дом"}
          response_message = JSON.parse(response.body)
          expect(response_message['message']).to eq 'correct translation notice'
        end

        it 'error' do
          card_id = user.cards.first.id
          post :review, { card_id: card_id, user_translation: "дача"}
          response_message = JSON.parse(response.body)
          expect(response_message['message']).to eq 'incorrect translation'
        end
      end
    end
  end
end
