# frozen_string_literal: true

module DepartmentsContext
  class Address < ApplicationRecord
    belongs_to :target, polymorphic: true
  end
end
