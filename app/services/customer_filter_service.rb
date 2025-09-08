# app/services/customer_filter_service.rb
class CustomerFilterService
    MUMBAI_LAT = 19.0590317
    MUMBAI_LON = 72.7553452
    RANGE_KM = 100

    def initialize(file)
      @file = file
    end

    def call
      customers = []
      @file.each_line do |line|
        begin
          customer = JSON.parse(line.strip)
          distance = HaversineService.distance(
            MUMBAI_LAT, MUMBAI_LON,
            customer["latitude"].to_f,
            customer["longitude"].to_f
          )

          if distance <= RANGE_KM
            customers << {
              user_id: customer["user_id"],
              name: customer["name"]
            }
          end
        rescue JSON::ParserError
          next
        end
      end

      customers.sort_by { |c| c[:user_id] }
    end
end
