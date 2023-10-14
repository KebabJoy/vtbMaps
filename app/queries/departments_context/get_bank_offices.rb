# frozen_string_literal: true

module DepartmentsContext
  class GetBankOffices < BaseQuery
    DEFAULT_RADIUS = 1000

    def initialize
      super { DepartmentsContext::BankOffice.all }
    end

    def where_nearest_to(*_args, latitude:, longitude:, **options)
      joined = with_ordered_addresses(latitude: latitude, longitude: longitude, **options)

      joined.select('bank_offices.*, sub_query.*').where("sub_query.point_distance < 2").order("point_distance ASC, bank_offices.load_value ASC")
    end

    def find_nearest_to(location:, **options)
      where_nearest_to(location: location, **options).order("point_distance ASC, bank_offices.load_value ASC").first
    end

    private

    def with_ordered_addresses(latitude:, longitude:, **options)
      coords = GisOperations.hash_to_point(lat: latitude.to_f, lon: longitude.to_f)

      DepartmentsContext::BankOffice.joins(<<-SQL.squish)
        LEFT JOIN LATERAL (
          SELECT ST_Distance('#{coords.to_s}', addresses.coords) / #{options[:radius] || DEFAULT_RADIUS} AS point_distance,
          addresses.id, addresses.target_id AS target_id
          FROM addresses WHERE target_type = 'DepartmentsContext::BankOffice'
        ) AS sub_query ON (bank_offices.id=sub_query.target_id)
      SQL
    end
  end
end
