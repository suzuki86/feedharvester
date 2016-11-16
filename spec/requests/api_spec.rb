require 'spec_helper'
require 'rails_helper'
require 'json'

describe API do
  describe "GET /api/v1/feeds" do
    before do
      FactoryGirl.create(:user_admin)
      FactoryGirl.create(:apikey_admin)
      FactoryGirl.create(:dummy_endpoints)
      FactoryGirl.create(:dummy_feeds)
    end

    it "returns 401 with invalid token" do
      headers = {
        "Authorization" => "Bearer 1234"
      }
      get "/api/v1/feeds", headers: headers
      expect(response.status).to eq(401)
    end

    it "returns feeds with valid token" do
      headers = {
        "Authorization" => "Bearer 398e5ff238efe5705dbca92b71a25c00"
      }
      get "/api/v1/feeds", headers: headers
      expect(response.status).to eq(200)

      json = JSON.parse(response.body)
      expect(json[0]["title"]).to eq "TEST TITLE"
    end
  end

  describe "POST /api/v1/endpoints" do
    before do
      FactoryGirl.create(:user_admin)
      FactoryGirl.create(:apikey_admin)
      FactoryGirl.create(:dummy_endpoints)
      FactoryGirl.create(:dummy_feeds)
    end

    it "creates new entrypoint" do
      headers = {
        "Authorization" => "Bearer 398e5ff238efe5705dbca92b71a25c00"
      }
      post "/api/v1/endpoints", params: {name: "abcd", endpoint: "http://example.com/hoge1234"}, headers: headers
      get "/api/v1/endpoints", headers: headers
      json = JSON.parse(response.body)
      expect(json[1]["name"]).to eq "abcd"
    end
  end
end
