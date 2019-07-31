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

ActiveRecord::Schema.define(version: 2019_07_31_072904) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coins", force: :cascade do |t|
    t.string "slug", null: false
    t.string "symbol", null: false
    t.string "name", null: false
    t.boolean "is_active", default: true, null: false
    t.integer "platform_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_coins_on_slug", unique: true
  end

  create_table "currencies", force: :cascade do |t|
    t.date "date", null: false
    t.integer "market_capitalization", null: false
    t.integer "value_usd_cents", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "coin_id", null: false
    t.index ["coin_id"], name: "index_currencies_on_coin_id"
  end

end
