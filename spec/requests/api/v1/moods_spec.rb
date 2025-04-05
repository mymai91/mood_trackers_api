require 'rails_helper'

RSpec.describe "Api::V1::Moods", type: :request do
  include ActiveSupport::Testing::TimeHelpers

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

  describe "GET /index" do
    before do
      # set anchor time 2025-04-05
      travel_to Time.zone.local(2025, 4, 5)
    end

    after { travel_back }

    let!(:user_ip) { create(:user_ip) }
    let!(:mood_today) { create(:mood, user_ip: user_ip) }
    let!(:mood_yesterday) { create(:mood, :created_yesterday, user_ip: user_ip) }
    let!(:mood_two_weeks_ago) { create(:mood, :created_two_weeks_ago, user_ip: user_ip) }
    let!(:mood_last_month) { create(:mood, :created_last_month, user_ip: user_ip) }

    let!(:different_user_ip) { create(:user_ip, :valid_ip_address2) }
    let!(:other_mood) { create(:mood, user_ip: different_user_ip) }

    it 'returns a success response' do
      get "/api/v1/moods",
          env: { "REMOTE_ADDR" => user_ip.ip_address }

      expect(response).to have_http_status(:success)

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response.dig(:data).count).to eq(1)
    end

    it 'returns moods for the weekly period' do
      get "/api/v1/moods",
          params: { period: "weekly" },
          env: { "REMOTE_ADDR" => user_ip.ip_address }

      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response.dig(:data).count).to eq(2)
    end

    it 'returns moods for the daily period' do
      get "/api/v1/moods",
          params: { period: "daily" },
          env: { "REMOTE_ADDR" => user_ip.ip_address }

      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response.dig(:data).count).to eq(1)
    end
  end
end
