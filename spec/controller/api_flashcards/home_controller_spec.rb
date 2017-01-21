require 'rails_helper'
require 'support/authentication_helper.rb'

module ApiFlashcards
  RSpec.describe HomeController, type: :controller do
    routes { ApiFlashcards::Engine.routes }

    describe "GET #index" do
      it "returns http success with right credentials" do
        authentication
        get :index
        expect(response).to have_http_status(:success)
      end

      context "returns 401 Unauthorised" do
        it "without login" do
          get :index
          expect(response.status).to eq 401
        end

        it "with wrong login" do
          request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'wrong')
          get :index
          expect(response.status).to eq 401
        end
      end
    end
  end
end
