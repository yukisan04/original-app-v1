require 'rails_helper'

RSpec.describe "Replies", type: :request do

  describe "GET /create" do
    it "returns http success" do
      get "/replies/create"
      expect(response).to have_http_status(:success)
    end
  end

end
