# frozen_string_literal: true

module DepartmentsContext
  class BankOffice < ApplicationRecord
    include Attributes

    has_one :address, as: :target, class_name: "Address"

    accepts_nested_attributes_for :address
  end
end
