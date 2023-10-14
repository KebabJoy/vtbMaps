# frozen_string_literal: true

require "swagger_helper"

describe "Atms", type: :request do
  path "/atms" do
    get "Список банкоматов" do
      common_with_tags "Банкоматы"

      parameter name: :latitude, in: :query, type: :number, format: :float
      parameter name: :longitude, in: :query, type: :number, format: :float

      let(:latitude) { 55.755819 }
      let(:longitude) { 37.317644 }

      success_response do
        schema type: :array, items: Swagger.read_definition("atms")

        let!(:atm) { create :atm }
        let!(:address) { create :address, :within_50_km_from_moscow, target: atm }

        run_test! do |response|
          expect(response.body).to be_json_eql(atm.id.to_json).at_path("0/id")
        end
      end
    end
  end

  path "/atm" do
    get "Список Банкоматов" do
      common_with_tags "Банкоматы"

      parameter name: :latitude, in: :query, type: :number, format: :float
      parameter name: :longitude, in: :query, type: :number, format: :float

      let(:latitude) { 55.755819 }
      let(:longitude) { 37.317644 }

      success_response do
        schema Swagger.read_definition("atms")

        let!(:atm) { create :atm }
        let!(:address) { create :address, :within_50_km_from_moscow, target: atm }

        run_test! do |response|
          expect(response.body).to be_json_eql(atm.id.to_json).at_path("id")
        end
      end
    end
  end
end
