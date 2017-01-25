require 'rails_helper'
require 'support/authentication_helper.rb'

module ApiFlashcards
  RSpec.describe HomeController, type: :controller do
    routes { ApiFlashcards::Engine.routes }

    describe "GET #index" do
      let!(:user) { create(:user) }

      context 'not success authenticate' do
        it 'have\'t access to api' do
          authentication(user.email, 'wrong')
          get :index
          expect(response.status).to eq 401
        end

        it "without login" do
          get :index
          expect(response.status).to eq 401
        end
      end

      context 'success authenticate' do
        it 'have access to api' do
          authentication(user.email, user.password)
          get :index
          expect(response.status).to eq 200
        end
      end
    end
  end
end
