# spec/integration/customers_spec.rb
require 'swagger_helper'

RSpec.describe 'Customers API', type: :request do
  path '/api/v1/customers/nearby' do
    post 'Upload customers file and filter by 100km radius' do
      consumes 'multipart/form-data'
      produces 'application/json'
      parameter name: :file, in: :formData, type: :file, description: 'The customers.txt file to upload', required: true

      response '200', 'customers found' do
        let(:file) do
          temp = Tempfile.new('customers.json')
          temp.write('{"user_id": 2, "name": "Near", "latitude": "19.1", "longitude": "72.8"}')
          temp.rewind
          Rack::Test::UploadedFile.new(temp.path, 'application/json')
        end
        run_test!
      end

      response '400', 'bad request' do
        let(:file) { nil }
        run_test!
      end
    end
  end
end
