# app/services/haversine_service.rb
class HaversineService
    EARTH_RADIUS_KM = 6371.0

    def self.distance(lat1, lon1, lat2, lon2)
      lat1_rad = to_radians(lat1)
      lon1_rad = to_radians(lon1)
      lat2_rad = to_radians(lat2)
      lon2_rad = to_radians(lon2)

      dlat = lat2_rad - lat1_rad
      dlon = lon2_rad - lon1_rad

      a = Math.sin(dlat / 2)**2 +
          Math.cos(lat1_rad) * Math.cos(lat2_rad) *
          Math.sin(dlon / 2)**2
      c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

      EARTH_RADIUS_KM * c
    end

    def self.to_radians(degrees)
      degrees.to_f * Math::PI / 180
    end
end
