require 'rails_helper'

RSpec.describe "Api::V1::Moods", type: :request do
  describe "POST /create" do
    it 'returns a success response' do
      post "/api/v1/moods", params: { mood: { emotion: "pretty_good", comment: "I have a great day today", rating: 3 } }

      expect(response).to have_http_status(:created)
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response.dig(:data, :attributes, :emotion)).to eq("pretty_good")
      expect(json_response.dig(:data, :attributes, :comment)).to eq("I have a great day today")
      expect(json_response.dig(:data, :attributes, :rating)).to eq(3)
    end

    it 'return unprocessable entity if already submited the daily mood' do
      user_ip = create(:user_ip)
      create(:mood, user_ip: user_ip, created_at: Date.today)

      post "/api/v1/moods",
          params: { mood: { emotion: "pretty_good", comment: "I have a great day today", rating: 3 } },
          env: { "REMOTE_ADDR" => user_ip.ip_address }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
