# frozen_string_literal: true

module DepartmentsContext
  class GetBankOffices < BaseQuery
    DEFAULT_RADIUS = 1000

    def initialize
      super(DepartmentsContext::BankOffice)
    end

    def with_nearest_to(location:, **options)
      coords = GisOperations.hash_to_point(lat: location[:latitude], lon: location[:longitude])

      joined = DepartmentsContext::BankOffice.joins(<<-SQL.squish)
        LEFT JOIN LATERAL (
          SELECT ST_Distance('#{coords.to_s}', addresses.coords) / #{options[:radius] || DEFAULT_RADIUS} AS point_distance,
          addresses.id, addresses.target_id AS target_id
          FROM addresses WHERE target_type = 'DepartmentsContext::BankOffice'
        ) AS sub_query ON (bank_offices.id=sub_query.target_id)
      SQL

      joined.select('bank_offices.*, sub_query.*').order("point_distance ASC, bank_offices.load_value ASC")
    end
  end
end
