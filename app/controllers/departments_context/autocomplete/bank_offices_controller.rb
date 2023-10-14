# frozen_string_literal: true

module DepartmentsContext
  module Autocomplete
    class BankOfficesController < ActionController::Base
      def index
        @bank_offices = GetBankOffices.new.call(:find_by_raw_value)
      end
    end
  end
end
