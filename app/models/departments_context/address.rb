# frozen_string_literal: true

module DepartmentsContext
  class Address < ApplicationRecord
    DEFAULT_RADIUS = 2000

    belongs_to :target, polymorphic: true
  end
end
