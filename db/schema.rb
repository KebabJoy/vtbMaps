# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_10_14_093334) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "addresses", force: :cascade do |t|
    t.text "raw_value"
    t.string "target_type", null: false
    t.bigint "target_id", null: false
    t.geography "coords", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}, comment: "Гео-координаты"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_type", "target_id"], name: "index_addresses_on_target"
  end

  create_table "atms", force: :cascade do |t|
    t.boolean "allday", default: false, comment: "Круглосуточно"
    t.jsonb "services", default: {}, null: false, comment: "Доступность отделения"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bank_offices", force: :cascade do |t|
    t.text "sale_point_name"
    t.jsonb "open_hours", default: {}, null: false, comment: "Расписание"
    t.jsonb "open_hours_individual", default: {}, null: false, comment: "Расписание для конкретного отделения"
    t.string "status", null: false
    t.boolean "rko", default: false, null: false
    t.string "office_type", null: false
    t.string "sale_point_format", null: false
    t.boolean "suo_availability", default: false
    t.boolean "has_ramp", default: false
    t.boolean "kep", default: false
    t.boolean "my_branch", default: false
    t.text "metro_station"
    t.integer "distance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
