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

ActiveRecord::Schema[7.1].define(version: 2023_11_29_095203) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "address"
    t.date "date"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activity_statuses", force: :cascade do |t|
    t.integer "participant"
    t.string "status"
    t.bigint "activity_id", null: false
    t.bigint "trip_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_activity_statuses_on_activity_id"
    t.index ["trip_id"], name: "index_activity_statuses_on_trip_id"
  end

  create_table "flight_statuses", force: :cascade do |t|
    t.integer "adult"
    t.string "status"
    t.bigint "flight_id", null: false
    t.bigint "trip_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flight_id"], name: "index_flight_statuses_on_flight_id"
    t.index ["trip_id"], name: "index_flight_statuses_on_trip_id"
  end

  create_table "flights", force: :cascade do |t|
    t.string "start_location"
    t.string "end_location"
    t.date "start_date"
    t.date "end_date"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hotels", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
  end

  create_table "room_statuses", force: :cascade do |t|
    t.string "room_name"
    t.date "start_date"
    t.date "end_date"
    t.integer "guest"
    t.float "price"
    t.string "status"
    t.bigint "hotel_id", null: false
    t.bigint "trip_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotel_id"], name: "index_room_statuses_on_hotel_id"
    t.index ["trip_id"], name: "index_room_statuses_on_trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "name"
    t.bigint "users_id", null: false
    t.bigint "locations_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locations_id"], name: "index_trips_on_locations_id"
    t.index ["users_id"], name: "index_trips_on_users_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "activity_statuses", "activities"
  add_foreign_key "activity_statuses", "trips"
  add_foreign_key "flight_statuses", "flights"
  add_foreign_key "flight_statuses", "trips"
  add_foreign_key "room_statuses", "hotels"
  add_foreign_key "room_statuses", "trips"
  add_foreign_key "trips", "locations", column: "locations_id"
  add_foreign_key "trips", "users", column: "users_id"
end
