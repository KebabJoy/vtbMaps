# frozen_string_literal: true

module DepartmentsContext
  module Autocomplete
    class BankOfficesController < ApplicationController
      def index
        @bank_offices = GetBankOffices.new.call(:find_by_raw_value, query: unsafe_params[:query])
      end
    end
  end
end
