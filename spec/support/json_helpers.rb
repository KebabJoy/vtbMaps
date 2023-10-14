module JsonHelpers
  def json_parse(json)
    JSON.parse(json, object_class: HashWithIndifferentAccess)
  end

  def json_body
    @json_body ||= json_parse(response.body)
  end
end

RSpec.configure do |config|
  config.include JsonHelpers
end

