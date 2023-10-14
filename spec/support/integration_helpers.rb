module IntegrationHelpers
  extend ActiveSupport::Concern

  class_methods do
    def common_with_tags(...)
      tags(...)
      json_api
    end

    def json_api
      produces "application/json"
      consumes "application/json"
    end

    # RESPONSES

    def success_response(status: 200, summary: "Success", contexts: {jwt_auth: true}, &block)
      contexts[:paginated] = true if with_pagination?
      response(status, summary, contexts, &block)
    end

    def created_response(status: 201, summary: "Created", contexts: {jwt_auth: true}, &block)
      response(status, summary, contexts, &block)
    end

    def unauthorized_response(contexts: {}, &block)
      response(401, "Unauthorized", contexts, &block)
    end

    def unprocessable_response(contexts: {jwt_auth: true}, &block)
      response(422, "Unprocessable", contexts, &block)
    end

    def forbidden_response(contexts: {jwt_auth: true}, &block)
      response(403, "Forbidden", contexts, &block)
    end

    def not_found_response(contexts: {jwt_auth: true}, &block)
      response(404, "Not Found", contexts, &block)
    end

    def no_content_response(contexts: {jwt_auth: true}, &block)
      response(204, "No content", contexts, &block)
    end

    private

    def pagination_parameters_item
      {
        name: :items,
        in: :query,
        type: :integer,
        required: false,
        descriptions: "Кол-во элементов на страницу пагинации"
      }
    end

    def pagination_parameters_page
      {
        name: :page,
        in: :query,
        type: :integer,
        required: false,
        descriptions: "Cтраница пагинации"
      }
    end

    def with_pagination?
      Array(metadata.dig(:operation, :parameters)).include?(pagination_parameters_item)
    end
  end
end
