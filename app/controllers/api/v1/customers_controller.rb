# app/controllers/api/v1/customers_controller.rb
class Api::V1::CustomersController < ApplicationController
    def nearby
        if params[:file].present?
            uploaded_file = params[:file]
            file = uploaded_file.respond_to?(:tempfile) ? uploaded_file.tempfile : uploaded_file

            service = CustomerFilterService.new(file)
            render json: service.call, status: :ok
        else
            render json: { error: "File is required" }, status: :bad_request
        end
    end
end
