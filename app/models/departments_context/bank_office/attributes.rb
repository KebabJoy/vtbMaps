# frozen_string_literal: true

module DepartmentsContext
  class BankOffice
    module Attributes
      extend ActiveSupport::Concern

      class Schedule
        include StoreModel::Model

        attribute :day, :string
        attribute :working_hours, :string
      end

      included do
        attribute :open_hours, Schedule.to_array_type
        attribute :open_hours_individual, Schedule.to_array_type
      end
    end
  end
end
