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

ActiveRecord::Schema.define(version: 20170207145608) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accommodations", force: :cascade do |t|
    t.string   "type"
    t.string   "name"
    t.string   "description"
    t.integer  "day_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["day_id"], name: "index_accommodations_on_day_id", using: :btree
  end

  create_table "days", force: :cascade do |t|
    t.integer  "index"
    t.integer  "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_days_on_trip_id", using: :btree
  end

  create_table "entertainments", force: :cascade do |t|
    t.string   "type"
    t.string   "name"
    t.string   "description"
    t.integer  "day_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["day_id"], name: "index_entertainments_on_day_id", using: :btree
  end

  create_table "food_and_beverages", force: :cascade do |t|
    t.string   "type"
    t.string   "name"
    t.string   "description"
    t.integer  "day_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["day_id"], name: "index_food_and_beverages_on_day_id", using: :btree
  end

  create_table "natures", force: :cascade do |t|
    t.string   "type"
    t.string   "name"
    t.string   "description"
    t.integer  "day_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["day_id"], name: "index_natures_on_day_id", using: :btree
  end

  create_table "point_of_interests", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "day_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["day_id"], name: "index_point_of_interests_on_day_id", using: :btree
  end

  create_table "transportations", force: :cascade do |t|
    t.string   "type"
    t.string   "name"
    t.string   "description"
    t.integer  "day_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["day_id"], name: "index_transportations_on_day_id", using: :btree
  end

  create_table "trip_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_trip_users_on_trip_id", using: :btree
    t.index ["user_id"], name: "index_trip_users_on_user_id", using: :btree
  end

  create_table "trips", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "public",      default: true
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "encrypted_password"
    t.text     "description"
    t.datetime "last_sign_in"
    t.datetime "last_sign_out"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

end
