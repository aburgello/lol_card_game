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

ActiveRecord::Schema[7.2].define(version: 2024_11_28_012128) do
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

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "challenges", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "reward"
    t.string "progress_type"
    t.integer "required_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "region_id"
    t.index ["region_id"], name: "index_challenges_on_region_id"
  end

  create_table "challenges_skins", id: false, force: :cascade do |t|
    t.bigint "challenge_id"
    t.bigint "skin_id"
    t.index ["challenge_id"], name: "index_challenges_skins_on_challenge_id"
    t.index ["skin_id"], name: "index_challenges_skins_on_skin_id"
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

  create_table "collections", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "skin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skin_id"], name: "index_collections_on_skin_id"
    t.index ["user_id"], name: "index_collections_on_user_id"
  end

  create_table "game_plays", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "game_id", null: false
    t.integer "score"
    t.integer "cores_earned"
    t.datetime "played_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_plays_on_game_id"
    t.index ["user_id", "game_id", "played_at"], name: "index_game_plays_on_user_game_and_date"
    t.index ["user_id"], name: "index_game_plays_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "min_reward", null: false
    t.integer "max_reward", null: false
    t.integer "daily_plays_limit", default: 3
    t.string "game_type"
    t.jsonb "game_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "logo"
    t.string "video_backdrop"
    t.string "image_backdrop"
    t.text "lore"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "skins", force: :cascade do |t|
    t.bigint "champion_id", null: false
    t.string "name"
    t.integer "num"
    t.string "splash_art"
    t.string "loading_art"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_base"
    t.text "description"
    t.string "rarity"
    t.boolean "is_legacy"
    t.string "splash_art_centered"
    t.index ["champion_id"], name: "index_skins_on_champion_id"
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_challenges", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "challenge_id", null: false
    t.boolean "completed"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id"], name: "index_user_challenges_on_challenge_id"
    t.index ["user_id"], name: "index_user_challenges_on_user_id"
  end

  create_table "user_champions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "champion_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["champion_id"], name: "index_user_champions_on_champion_id"
    t.index ["user_id"], name: "index_user_champions_on_user_id"
  end

  create_table "user_regions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "region_id", null: false
    t.datetime "discovered_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["region_id"], name: "index_user_regions_on_region_id"
    t.index ["user_id", "region_id"], name: "index_user_regions_on_user_id_and_region_id", unique: true
    t.index ["user_id"], name: "index_user_regions_on_user_id"
  end

  create_table "user_skins", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "skin_id", null: false
    t.datetime "unlocked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skin_id"], name: "index_user_skins_on_skin_id"
    t.index ["user_id"], name: "index_user_skins_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.boolean "admin"
    t.integer "hextech_cores", default: 800, null: false
    t.integer "quiz_attempts_today", default: 0
    t.integer "ability_guess_attempts_today", default: 0
    t.integer "skin_snippet_attempts_today", default: 0
    t.integer "skin_name_attempts_today", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "abilities", "champions"
  add_foreign_key "challenges", "regions"
  add_foreign_key "champion_types", "champions"
  add_foreign_key "champion_types", "types"
  add_foreign_key "champions", "regions"
  add_foreign_key "collections", "skins"
  add_foreign_key "collections", "users"
  add_foreign_key "game_plays", "games"
  add_foreign_key "game_plays", "users"
  add_foreign_key "skins", "champions"
  add_foreign_key "user_challenges", "challenges"
  add_foreign_key "user_challenges", "users"
  add_foreign_key "user_champions", "champions"
  add_foreign_key "user_champions", "users"
  add_foreign_key "user_regions", "regions"
  add_foreign_key "user_regions", "users"
  add_foreign_key "user_skins", "skins"
  add_foreign_key "user_skins", "users"
end
