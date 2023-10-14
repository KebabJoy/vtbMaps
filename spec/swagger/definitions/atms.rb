{
  type: :object,
  properties: {
    id: {type: :integer},
    allday: {type: :boolean},
    services: {
      type: :object,
      properties: Swagger.read_definition("partials/atm_services")
    },
    **Swagger.read_definition("address")
  },
  required: %i[],
  additionalProperties: false
}
