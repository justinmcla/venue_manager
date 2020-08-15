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

ActiveRecord::Schema.define(version: 2020_08_15_173745) do

  create_table "bookings", force: :cascade do |t|
    t.string "name"
    t.string "event_type"
    t.date "date"
    t.string "time"
    t.text "description"
    t.integer "attendance"
    t.boolean "food"
    t.boolean "alcohol"
    t.boolean "lighting"
    t.boolean "sound"
    t.boolean "microphones"
    t.boolean "street_closure"
    t.boolean "spotlight"
    t.boolean "curtain"
    t.boolean "security"
    t.boolean "contract"
    t.boolean "deposit"
    t.boolean "paid"
    t.integer "venue_id"
    t.integer "tenant_id"
  end

  create_table "inventories", force: :cascade do |t|
    t.string "name"
    t.integer "venue_id"
    t.text "description"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.integer "quantity"
    t.text "description"
    t.integer "inventory_id"
  end

  create_table "tenants", force: :cascade do |t|
    t.string "org_type"
    t.string "org_name"
    t.string "org_address"
    t.string "org_city"
    t.string "org_state"
    t.string "org_zip"
    t.string "poc_name"
    t.string "poc_phone"
    t.string "poc_email"
    t.integer "user_id"
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
    t.integer "greenrooms"
    t.integer "dressing_rooms"
    t.integer "user_id"
  end

end
