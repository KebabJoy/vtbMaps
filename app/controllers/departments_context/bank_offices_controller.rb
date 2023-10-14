# frozen_string_literal: true

module DepartmentsContext
  class BankOfficesController < ApplicationController
    def index
      binding.pry
      @bank_offices =
        GetBankOffices
          .new
          .call(
            :where_nearest_to,
            latitude: unsafe_params[:latitude],
            longitude:  unsafe_params[:longitude]
          )
    end
  end
end
