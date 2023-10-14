# frozen_string_literal: true

module DepartmentsContext
  class AtmsController < ActionController::Base
    def index
      @bank_offices = GetAtms.new.call(:all)
    end
  end
end
