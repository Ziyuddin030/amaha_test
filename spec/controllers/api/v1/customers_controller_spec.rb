require "rails_helper"

RSpec.describe Api::V1::CustomersController, type: :controller do
  routes { Rails.application.routes }
  describe "POST #nearby" do
    it "returns bad_request when file param is missing" do
      post :nearby, params: {}

      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to include("error" => "File is required")
    end

    it "invokes service and returns its result as JSON" do
      temp = Tempfile.new("customers.json")
      begin
        uploaded = Rack::Test::UploadedFile.new(temp.path, "application/json")

        result = [
          { "user_id" => 1, "name" => "Alice" },
          { "user_id" => 2, "name" => "Bob" }
        ]

        service_double = instance_double(CustomerFilterService)
        allow(CustomerFilterService).to receive(:new).and_return(service_double)
        allow(service_double).to receive(:call).and_return(result)

        post :nearby, params: { file: uploaded }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq(result)
      ensure
        temp.close
        temp.unlink
      end
    end
  end
end
