# frozen_string_literal: true

module DepartmentsContext
  class GetBankOffices < BaseQuery
    def initialize
      super { BankOffice.includes(:address) }
    end

    def where_nearest_to(collection, *_args, latitude:, longitude:, **options)
      joined = with_ordered_addresses(collection, latitude: latitude, longitude: longitude, **options)

      joined.select('bank_offices.*, sub_query.*').where("sub_query.point_distance < 1").order("point_distance ASC, bank_offices.load_value ASC")
    end

    def find_nearest_to(collection, location:, **options)
      where_nearest_to(collection,location: location, **options).order("point_distance ASC, bank_offices.load_value ASC").first
    end

    private

    def with_ordered_addresses(collection, latitude:, longitude:, **options)
      coords = GisOperations.hash_to_point(lat: latitude.to_f, lon: longitude.to_f)

      collection.joins(<<-SQL.squish)
        LEFT JOIN LATERAL (
          SELECT ST_Distance('#{coords.to_s}', addresses.coords) / #{options[:radius] || Address::DEFAULT_RADIUS} AS point_distance,
          addresses.id, addresses.target_id AS target_id
          FROM addresses WHERE target_type = 'DepartmentsContext::BankOffice'
        ) AS sub_query ON (bank_offices.id=sub_query.target_id)
      SQL
    end
  end
end
