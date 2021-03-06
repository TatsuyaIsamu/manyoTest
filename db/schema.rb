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

ActiveRecord::Schema.define(version: 2021_06_10_122021) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "combinations", force: :cascade do |t|
    t.bigint "task_id"
    t.bigint "label_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["label_id"], name: "index_combinations_on_label_id"
    t.index ["task_id"], name: "index_combinations_on_task_id"
  end

  create_table "labels", force: :cascade do |t|
    t.text "label_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_labels_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.text "title", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "deadline"
    t.string "status"
    t.integer "priority", default: 0
    t.bigint "user_id"
    t.index ["content"], name: "index_tasks_on_content"
    t.index ["title"], name: "index_tasks_on_title"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "name"
    t.text "email"
    t.text "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin_role", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "combinations", "labels"
  add_foreign_key "combinations", "tasks"
  add_foreign_key "labels", "users"
  add_foreign_key "tasks", "users"
end
