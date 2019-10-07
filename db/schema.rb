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

ActiveRecord::Schema.define(version: 2019_10_07_025113) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "organizers", force: :cascade do |t|
    t.string "username"
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "organizers_sessions", id: false, force: :cascade do |t|
    t.bigint "organizer_id", null: false
    t.bigint "session_id", null: false
    t.index ["organizer_id", "session_id"], name: "index_organizers_sessions_on_organizer_id_and_session_id"
    t.index ["session_id", "organizer_id"], name: "index_organizers_sessions_on_session_id_and_organizer_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "title"
    t.datetime "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sessions_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "session_id", null: false
    t.index ["session_id", "user_id"], name: "index_sessions_users_on_session_id_and_user_id"
    t.index ["user_id", "session_id"], name: "index_sessions_users_on_user_id_and_session_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "name"
    t.string "email"
    t.string "friends", default: [], array: true
    t.string "past_partners", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
