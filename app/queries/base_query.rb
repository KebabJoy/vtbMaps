# frozen_string_literal: true

class BaseQuery
  attr_reader :base_collection

  def initialize(collection_klass)
    @base_collection = collection_klass.all
  end

  def call(method_name, *args, **options)
    method(method_name).call(*args, **options)
  end
end
