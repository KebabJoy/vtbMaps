# frozen_string_literal: true

module DepartmentsContext
  module Autocomplete
    class GetBankOffices < BaseQuery
      def initialize
        super { BankOffice.includes(:address) }
      end

      def find_by_raw_value(collection, query:)
        collection.joins(:address).where("addresses.raw_value LIKE ?", "%#{query}%")
      end
    end
  end
end
