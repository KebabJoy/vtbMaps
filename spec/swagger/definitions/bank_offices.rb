{
  type: :object,
  properties: {
    id: {type: :integer},
    load_value: {type: :integer},
    sale_point_name: {type: :string},
    status: {type: :string},
    office_type: {type: :string},
    sale_point_format: {type: :string},
    rko: {type: :boolean},
    suo_availability: {type: :boolean},
    has_ramp: {type: :boolean},
    kep: {type: :boolean},
    my_branch: {type: :boolean},
    open_hours: {
      type: :array,
      items: {
        type: :object,
        properties: {
          days: {type: :string},
          hours: {type: :string}
        }
      }
    },
    open_hours_individual: {
      type: :array,
      items: {
        type: :object,
        properties: {
          days: {type: :string},
          hours: {type: :string}
        }
      }
    },
    **Swagger.read_definition("address")
  },
  required: %i[],
  additionalProperties: false
}
