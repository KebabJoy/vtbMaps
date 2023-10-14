# frozen_string_literal: true

module DepartmentsContext
  class GetAtms < BaseQuery
    def initialize
      super { Atm.all }
    end

    def where_nearest_to(collection, *_args, latitude:, longitude:, **options)
      joined = with_ordered_addresses(collection, latitude: latitude, longitude: longitude, **options)

      joined.select('atms.*, sub_query.*').where("sub_query.point_distance < 2").order("point_distance ASC")
    end

    def find_nearest_to(collection, location:, **options)
      where_nearest_to(collection,location: location, **options).order("point_distance ASC").first
    end

    private

    def with_ordered_addresses(collection, latitude:, longitude:, **options)
      coords = GisOperations.hash_to_point(lat: latitude.to_f, lon: longitude.to_f)

      collection.joins(<<-SQL.squish)
        LEFT JOIN LATERAL (
          SELECT ST_Distance('#{coords.to_s}', addresses.coords) / #{options[:radius] || Address::DEFAULT_RADIUS} AS point_distance,
          addresses.id, addresses.target_id AS target_id
          FROM addresses WHERE target_type = 'DepartmentsContext::BankOffice'
        ) AS sub_query ON (atms.id=sub_query.target_id)
      SQL
    end
  end
end
