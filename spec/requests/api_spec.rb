require 'spec_helper'
require 'rails_helper'

describe API do
  describe "GET /api/v1/feeds" do
    it "returns 401" do
      headers = {
        "Authorization" => "Bearer 1234"
      }
      get "/api/v1/feeds", headers: headers
      expect(response.status).to eq(401)
    end

    it "returns 200" do
      FactoryGirl.create(:user_admin)
      FactoryGirl.create(:apikey_admin)
      headers = {
        "Authorization" => "Bearer 398e5ff238efe5705dbca92b71a25c00"
      }
      get "/api/v1/feeds", headers: headers
      expect(response.status).to eq(200)
    end
  end
end
