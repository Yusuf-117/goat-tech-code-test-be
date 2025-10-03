require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let!(:user1) { User.create!(name: "Alice", email: "alice@example.com") }
  let!(:user2) { User.create!(name: "Bob", email: "bob@example.com") }

  describe "GET /api/v1/users" do
    it "returns all users" do
      get "/api/v1/users"
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['users'].length).to eq(2)
    end
  end

  describe "GET /api/v1/users/:id" do
    it "returns a single user" do
      get "/api/v1/users/#{user1.id}"
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['user']['name']).to eq("Alice")
    end
  end

  describe "POST /api/v1/users" do
    it "creates a new user" do
      expect {
        post "/api/v1/users", params: { user: { name: "Charlie", email: "charlie@example.com" } }
      }.to change(User, :count).by(1)

      expect(response).to have_http_status(:created)
    end
  end
end