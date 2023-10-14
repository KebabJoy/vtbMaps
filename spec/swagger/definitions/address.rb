{
  raw_value: {type: :string},
  coords: {
    type: :object,
    properties: {
      lat: {type: :number, format: :float, nullable: true},
      lon: {type: :number, format: :float, nullable: true}
    },
    nullable: true,
    required: %i[lat lon],
    additionalProperties: false
  }
}
