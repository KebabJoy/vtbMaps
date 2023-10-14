# frozen_string_literal: true

require "swagger_helper"

describe "Bank Accounts", type: :request do
  path "/bank_offices" do
    get "Список отделений" do
      common_with_tags "Отделения"

      parameter name: :latitude, in: :query, type: :number, format: :float
      parameter name: :longitude, in: :query, type: :number, format: :float

      let(:latitude) { 55.755819 }
      let(:longitude) { 37.317644 }

      success_response do
        let!(:office) { create :bank_office }
        let!(:address) { create :address, :within_50_km_from_moscow, target: office }

        run_test! do |response|
          expect(response.body).to be_json_eql(office.id.to_json).at_path("0/id")
        end
      end
    end
  end
end
