# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150905162548) do

  create_table "captains", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cups", force: :cascade do |t|
    t.integer  "team_id"
    t.string   "name"
    t.string   "cup_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.boolean  "has_league"
    t.boolean  "has_tournament"
    t.integer  "max_team"
  end

  add_index "cups", ["cup_url"], name: "index_cups_on_cup_url", unique: true
  add_index "cups", ["team_id"], name: "index_cups_on_team_id"

  create_table "cups_teams", id: false, force: :cascade do |t|
    t.integer "cup_id"
    t.integer "team_id"
  end

  add_index "cups_teams", ["cup_id"], name: "index_cups_teams_on_cup_id"
  add_index "cups_teams", ["team_id"], name: "index_cups_teams_on_team_id"

  create_table "matches", force: :cascade do |t|
    t.integer  "cup_id"
    t.datetime "date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "home_team_id"
    t.integer  "away_team_id"
    t.string   "description"
    t.integer  "half"
    t.integer  "extra"
    t.boolean  "penalty"
    t.integer  "tzinfo"
  end

  create_table "organizers", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "cup_id"
  end

  create_table "referees", force: :cascade do |t|
    t.integer  "match_id"
    t.integer  "organizer_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "team_applicants", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "cup_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "applying",   default: true
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "captain_user_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "team_url"
    t.string   "gender"
    t.integer  "average_age"
    t.integer  "users_count",         default: 0
    t.boolean  "phone",               default: false
    t.boolean  "student_code",        default: false
    t.boolean  "career",              default: false
    t.text     "uniform_description"
  end

  add_index "teams", ["team_url"], name: "index_teams_on_team_url", unique: true

  create_table "teams_users", id: false, force: :cascade do |t|
    t.integer "team_id"
    t.integer "user_id"
  end

  add_index "teams_users", ["team_id"], name: "index_teams_users_on_team_id"
  add_index "teams_users", ["user_id"], name: "index_teams_users_on_user_id"

  create_table "user_infos", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "phone"
    t.string   "student_code"
    t.string   "career"
    t.boolean  "applying",     default: true
  end

  add_index "user_infos", ["team_id"], name: "index_user_infos_on_team_id"
  add_index "user_infos", ["user_id"], name: "index_user_infos_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "first_name",             default: "길동"
    t.string   "last_name",              default: "홍"
    t.integer  "age"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
