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

ActiveRecord::Schema[7.1].define(version: 2024_03_09_180516) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "email", null: false
    t.string "username", null: false
    t.integer "group", null: false
    t.datetime "start_time", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "end_time"
    t.integer "session_duration_seconds"
    t.integer "elo_session_start", null: false
    t.integer "elo_session_end"
    t.boolean "placement_challenges_finished_session_start", null: false
    t.boolean "placement_challenges_finished_session_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "elo_difference"
    t.string "league_session_start"
    t.integer "league_position_session_start"
    t.integer "league_size_session_start"
    t.string "league_session_end"
    t.integer "league_position_session_end"
    t.integer "league_size_session_end"
    t.integer "global_position_session_start"
    t.integer "global_leaderboard_size_session_start"
    t.integer "global_position_session_end"
    t.integer "global_leaderboard_size_session_end"
  end

  create_table "pre_authorized_emails", force: :cascade do |t|
    t.string "email", null: false
    t.integer "group", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((email)::text)", name: "index_pre_authorized_emails_on_LOWER_email", unique: true
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "solutions", force: :cascade do |t|
    t.string "user_email", null: false
    t.string "challenge_oid", null: false
    t.datetime "start_time", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "end_time"
    t.string "answer"
    t.boolean "answer_correct"
    t.integer "new_elo"
    t.integer "elo_change"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "score"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "user_type", default: 0, null: false
    t.integer "group", null: false
    t.string "username", null: false
    t.boolean "email_notifications", default: true
    t.string "email_unsubscribe_token", null: false
    t.integer "elo", default: 1000, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["email_unsubscribe_token"], name: "index_users_on_email_unsubscribe_token", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
