# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_03_11_150437) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "areas", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "slug", null: false
    t.text "description"
    t.uuid "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_areas_on_location_id"
  end

  create_table "attraction_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "slug", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attractions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "slug", null: false
    t.text "description"
    t.date "opening_date"
    t.date "closing_date"
    t.float "top_speed"
    t.float "height"
    t.float "length"
    t.integer "inversions"
    t.integer "capacity"
    t.uuid "location_id"
    t.uuid "area_id"
    t.uuid "attraction_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "manufacturer_id"
    t.index ["area_id"], name: "index_attractions_on_area_id"
    t.index ["attraction_type_id"], name: "index_attractions_on_attraction_type_id"
    t.index ["location_id"], name: "index_attractions_on_location_id"
    t.index ["manufacturer_id"], name: "index_attractions_on_manufacturer_id"
  end

  create_table "locations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "slug", null: false
    t.text "description"
    t.text "address"
    t.float "latitude"
    t.float "longitude"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "google_place_id"
    t.uuid "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_locations_on_parent_id"
  end

  create_table "manufacturers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "slug", null: false
    t.string "description"
    t.string "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", null: false
    t.datetime "created_at"
    t.index ["slug", "sluggable_type"], name: "index_slugs_on_slug_and_sluggable_type", unique: true
    t.index ["sluggable_id"], name: "index_slugs_on_sluggable_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "areas", "locations"
  add_foreign_key "attractions", "areas"
  add_foreign_key "attractions", "attraction_types"
  add_foreign_key "attractions", "locations"
  add_foreign_key "attractions", "manufacturers"
end
