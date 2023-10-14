# frozen_string_literal: true

require 'rails_helper'

module Swagger
  module_function

  def read_definitions(path)
    pattern = Rails.root.join("spec/swagger/definitions/#{path}/*.rb")

    Dir[pattern].to_h { |model_path|
      [File.basename(model_path, ".rb"), read_definition(model_path, expand: false)]
    }
  end

  def read_definition(path, expand: true)
    expanded_path = expand ? Rails.root.join("spec/swagger/definitions/#{path}.rb") : path
    eval File.read(expanded_path)
  rescue Exception => e
    raise "Error occured on reading #{expanded_path}: #{e.class} - #{e.message}"
  end
end

RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s
  config.include IntegrationHelpers
  config.define_derived_metadata(file_path: Regexp.new("/spec/integration")) do |metadata|
    metadata[:swagger_doc] = "v1/swagger.yaml"
  end

  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      servers: [
        {url: "http://localhost:3000/"}
      ],
      schemas: Swagger.read_definitions("")
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
