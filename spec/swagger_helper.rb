# frozen_string_literal: true

require 'rails_helper'

module Swagger
  module_function

  def ref(name)
    {"$ref" => "#/components/schemas/#{name}"}
  end
end

RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s
  config.include IntegrationHelpers
  config.define_derived_metadata(file_path: Regexp.new("/spec/integration")) do |metadata|
    metadata[:swagger_doc] = "web.yaml"
  end

  config.swagger_docs = {
    'web.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: 'https://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'www.example.com'
            }
          }
        },
        {url: "http://localhost:3000/web"}
      ]
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
