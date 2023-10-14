# frozen_string_literal: true

module DepartmentsContext
  class BankOfficesController < ActionController::Base
    def index
      @bank_offices = GetBankOffices.new.call(:all)
    end
  end
end
