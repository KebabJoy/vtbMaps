class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.text :raw_value
      t.references :target, polymorphic: true, null: false, index: true
      t.geography :coords, limit: {srid: 4326, type: "st_point", geographic: true}, comment: "Гео-координаты"

      t.timestamps
    end
  end
end
