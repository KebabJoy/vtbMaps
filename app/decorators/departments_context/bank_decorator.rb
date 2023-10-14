# frozen_string_literal: true

module DepartmentsContext
  class BankDecorator
    attr_reader :banks_query

    def initialize(rows)
      @banks_query = rows
    end

    def call
      banks_query.sort_by { sorting_criteria(_1) }
    end

    private

    def sorting_criteria(record)
      [
        record.point_distance,
        record.load_value
      ].compact
    end

    def score

    end
  end
end
