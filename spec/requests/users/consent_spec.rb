require 'rails_helper'

RSpec.describe "Users::Consents", type: :request do
  describe "GET /consent" do
    it "returns http success" do
      get "/users/consent/consent"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /submit_consent" do
    it "returns http success" do
      get "/users/consent/submit_consent"
      expect(response).to have_http_status(:success)
    end
  end

end
