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

ActiveRecord::Schema[7.2].define(version: 2024_11_16_000401) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abilities", force: :cascade do |t|
    t.bigint "champion_id", null: false
    t.string "name"
    t.text "description"
    t.string "image"
    t.string "ability_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["champion_id"], name: "index_abilities_on_champion_id"
  end

  create_table "champion_types", force: :cascade do |t|
    t.bigint "champion_id", null: false
    t.bigint "type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["champion_id"], name: "index_champion_types_on_champion_id"
    t.index ["type_id"], name: "index_champion_types_on_type_id"
  end

  create_table "champions", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.text "lore"
    t.string "splash_art"
    t.string "square_art"
    t.string "passive_name"
    t.text "passive_description"
    t.string "passive_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "region_id"
    t.index ["region_id"], name: "index_champions_on_region_id"
  end

  create_table "champions_types", id: false, force: :cascade do |t|
    t.bigint "champion_id", null: false
    t.bigint "type_id", null: false
    t.index ["champion_id"], name: "index_champions_types_on_champion_id"
    t.index ["type_id"], name: "index_champions_types_on_type_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skins", force: :cascade do |t|
    t.bigint "champion_id", null: false
    t.string "name"
    t.integer "num"
    t.string "splash_art"
    t.string "loading_art"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["champion_id"], name: "index_skins_on_champion_id"
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "abilities", "champions"
  add_foreign_key "champion_types", "champions"
  add_foreign_key "champion_types", "types"
  add_foreign_key "champions", "regions"
  add_foreign_key "skins", "champions"
end
