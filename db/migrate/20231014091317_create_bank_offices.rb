class CreateBankOffices < ActiveRecord::Migration[7.0]
  def change
    create_table :bank_offices do |t|
      t.text :sale_point_name
      t.jsonb :open_hours, null: false, default: {}, comment: "Расписание"
      t.jsonb :open_hours_individual, null: false, default: {}, comment: "Расписание для конкретного отделения"
      t.string :status, null: false
      t.boolean :rko, null: false, default: false
      t.string :office_type, null: false
      t.string :sale_point_format, null: false
      t.boolean :suo_availability, default: false
      t.boolean :has_ramp, default: false
      t.boolean :kep, default: false
      t.boolean :my_branch, default: false
      t.text :metro_station
      t.integer :distance

      t.timestamps
    end
  end
end
