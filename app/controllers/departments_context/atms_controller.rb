# frozen_string_literal: true

module DepartmentsContext
  class AtmsController < ApplicationController
    def index
      @atms =
        GetAtms
          .new
          .call(
            :where_nearest_to,
            latitude: unsafe_params[:latitude],
            longitude:  unsafe_params[:longitude]
          )
    end
  end
end
