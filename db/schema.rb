# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_08_045911) do

  create_table "bookings", force: :cascade do |t|
    t.string "customer"
    t.date "date"
    t.datetime "time"
    t.integer "venue_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "password_digest"
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.integer "zip"
    t.string "stage_type"
    t.integer "seats"
  end

end
