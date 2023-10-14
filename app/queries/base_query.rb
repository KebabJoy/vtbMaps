# frozen_string_literal: true

class BaseQuery
  attr_reader :base_collection

  def initialize(&base_collection)
    @base_collection = base_collection
  end

  def call(method_name = :all, *args, **options)
    public_send(method_name, base_collection.call, *args, **options)
  end

  def all(collection)
    collection
  end
end
