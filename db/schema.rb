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

ActiveRecord::Schema.define(version: 20171209081415) do

  create_table "chores", force: :cascade do |t|
    t.string "name"
    t.string "frequency"
    t.string "time_of_day"
    t.string "status", default: "not done"
    t.boolean "past_due", default: false
    t.integer "list_id"
    t.datetime "reset_time"
    t.datetime "past_due_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invites", force: :cascade do |t|
    t.string "status", default: "open"
    t.datetime "exp_date"
    t.string "email"
    t.integer "list_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lists", force: :cascade do |t|
    t.string "name"
    t.string "list_type"
    t.integer "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lists_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "list_id"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
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
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.boolean "member", default: true
    t.boolean "admin", default: false
    t.string "imgurl", default: "user.png"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["imgurl"], name: "index_users_on_imgurl"
    t.index ["name"], name: "index_users_on_name"
    t.index ["provider"], name: "index_users_on_provider"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid"], name: "index_users_on_uid"
  end

end
