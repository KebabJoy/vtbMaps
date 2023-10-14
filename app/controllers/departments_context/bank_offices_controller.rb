# frozen_string_literal: true

module DepartmentsContext
  class BankOfficesController < ActionController::Base
    def index
      GetBankOffices.new.call(:where_nearest_to, **params.to_unsafe_h)
    end
  end
end
