require 'rails_helper'

RSpec.describe "Api::V1::Campaigns", type: :request do
  let!(:campaign1) { Campaign.create!(name: "Campaign 1", status: "active") }
  let!(:campaign2) { Campaign.create!(name: "Campaign 2", status: "completed") }

  describe "GET /api/v1/campaigns" do
    it "returns all campaigns" do
      get "/api/v1/campaigns"
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['campaigns'].length).to eq(2)
    end

    it "includes task_count in response" do
      get "/api/v1/campaigns"
      json = JSON.parse(response.body)
      expect(json['campaigns'].first).to have_key('task_count')
    end

    it "filters by status" do
      get "/api/v1/campaigns?status=active"
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['campaigns'].length).to eq(1)
      expect(json['campaigns'].first['name']).to eq("Campaign 1")
    end
  end

  describe "GET /api/v1/campaigns/:id" do
    it "returns a single campaign" do
      get "/api/v1/campaigns/#{campaign1.id}"
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['campaign']['name']).to eq("Campaign 1")
    end

    it "includes tasks in response" do
      skip "Task model not yet created" unless defined?(Task)

      task = campaign1.tasks.create!(title: "Test Task")
      get "/api/v1/campaigns/#{campaign1.id}"
      json = JSON.parse(response.body)
      expect(json['campaign']['tasks']).to be_present
      expect(json['campaign']['tasks'].length).to eq(1)
    end

    it "returns 404 for non-existent campaign" do
      get "/api/v1/campaigns/99999"
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /api/v1/campaigns" do
    it "creates a new campaign" do
      expect {
        post "/api/v1/campaigns", params: { campaign: { name: "New Campaign" } }
      }.to change(Campaign, :count).by(1)

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json['campaign']['name']).to eq("New Campaign")
    end

    it "returns errors for invalid campaign" do
      post "/api/v1/campaigns", params: { campaign: { description: "No name" } }
      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body)
      expect(json['errors']).to be_present
    end
  end

  describe "PATCH /api/v1/campaigns/:id" do
    it "updates a campaign" do
      patch "/api/v1/campaigns/#{campaign1.id}",
            params: { campaign: { name: "Updated Name", status: "completed" } }

      expect(response).to have_http_status(:success)
      campaign1.reload
      expect(campaign1.name).to eq("Updated Name")
      expect(campaign1.status).to eq("completed")
    end
  end

  describe "DELETE /api/v1/campaigns/:id" do
    it "deletes a campaign" do
      expect {
        delete "/api/v1/campaigns/#{campaign1.id}"
      }.to change(Campaign, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end

    it "deletes associated tasks" do
      skip "Task model not yet created" unless defined?(Task)

      campaign1.tasks.create!(title: "Test Task")
      expect {
        delete "/api/v1/campaigns/#{campaign1.id}"
      }.to change(Task, :count).by(-1)
    end
  end
end