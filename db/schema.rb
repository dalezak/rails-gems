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

ActiveRecord::Schema[7.0].define(version: 2022_02_18_204116) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "gems", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "type", default: "Gemm"
    t.string "slug"
    t.string "name"
    t.text "title"
    t.text "description"
    t.string "version"
    t.string "platform"
    t.jsonb "details", default: {}
    t.jsonb "authors", default: [], array: true
    t.jsonb "licenses", default: [], array: true
    t.integer "tags_count", default: 0
    t.integer "likes_count", default: 0
    t.integer "downloads_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "forks_count", default: 0
    t.integer "stars_count", default: 0
    t.integer "watchers_count", default: 0
    t.index ["downloads_count"], name: "index_gems_on_downloads_count"
    t.index ["forks_count"], name: "index_gems_on_forks_count"
    t.index ["likes_count"], name: "index_gems_on_likes_count"
    t.index ["slug"], name: "index_gems_on_slug"
    t.index ["stars_count"], name: "index_gems_on_stars_count"
    t.index ["tags_count"], name: "index_gems_on_tags_count"
    t.index ["watchers_count"], name: "index_gems_on_watchers_count"
  end

  create_table "identities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.string "refresh_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider"], name: "index_identities_on_provider"
    t.index ["refresh_token"], name: "index_identities_on_refresh_token"
    t.index ["token"], name: "index_identities_on_token"
    t.index ["uid"], name: "index_identities_on_uid"
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "likes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "gem_id", null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gem_id"], name: "index_likes_on_gem_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "taggings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "gem_id", null: false
    t.uuid "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gem_id", "tag_id"], name: "index_taggings_on_gem_id_and_tag_id", unique: true
    t.index ["gem_id"], name: "index_taggings_on_gem_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.jsonb "synonyms", default: [], array: true
    t.integer "taggings_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name"
    t.index ["slug"], name: "index_tags_on_slug"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "type", default: "User"
    t.string "slug"
    t.string "name"
    t.string "title"
    t.text "description"
    t.jsonb "image_data"
    t.jsonb "details", default: {}
    t.integer "likes_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "identities_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug"
    t.index ["type"], name: "index_users_on_type"
  end

  add_foreign_key "identities", "users"
  add_foreign_key "likes", "gems"
  add_foreign_key "likes", "users"
  add_foreign_key "taggings", "gems"
  add_foreign_key "taggings", "tags"
end
