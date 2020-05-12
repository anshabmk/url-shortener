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

ActiveRecord::Schema.define(version: 2020_05_12_161721) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "short_links", force: :cascade do |t|
    t.string "token"
    t.text "long_url"
    t.integer "clicks_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "expiry_at", null: false
    t.index ["token"], name: "index_short_links_on_token"
  end

  create_table "urls", force: :cascade do |t|
    t.string "short_url"
    t.string "long_url"
    t.integer "visits_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "visits", force: :cascade do |t|
    t.bigint "short_link_id", null: false
    t.string "ip_address"
    t.string "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["short_link_id"], name: "index_visits_on_short_link_id"
  end

  add_foreign_key "visits", "short_links"
end
