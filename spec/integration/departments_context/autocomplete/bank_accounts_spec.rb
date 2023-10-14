# frozen_string_literal: true

require "swagger_helper"

describe "Bank Accounts autocomplete", type: :request do
  path "/autocomplete/bank_offices" do
    get "Список отделений" do
      common_with_tags "Отделения"

      parameter name: :query, in: :query, type: :string

      let(:query) { "est" }

      success_response do
        schema Swagger.read_definition("bank_offices")

        let!(:office) { create :bank_office }
        let!(:address) { create :address, :within_50_km_from_moscow, target: office, raw_value: "test street" }

        run_test! do |response|
          expect(response.body).to be_json_eql(office.id.to_json).at_path("id")
        end
      end
    end
  end
end
