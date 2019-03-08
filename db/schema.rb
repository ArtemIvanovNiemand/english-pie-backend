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

ActiveRecord::Schema.define(version: 2019_03_03_092838) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "choose_exercises", force: :cascade do |t|
    t.string "variants", null: false, array: true
    t.integer "answer", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exercises", force: :cascade do |t|
    t.integer "lesson_id"
    t.string "exercise_type"
    t.bigint "exercise_id"
    t.string "name", null: false
    t.string "description", null: false
    t.integer "sort_order", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_type", "exercise_id"], name: "index_exercises_on_exercise_type_and_exercise_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "level"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_groups_on_token"
  end

  create_table "groups_lessons", id: false, force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "lesson_id", null: false
    t.integer "order"
    t.index ["group_id", "lesson_id"], name: "index_groups_lessons_on_group_id_and_lesson_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sort_order"
    t.index ["group_id"], name: "index_lessons_on_group_id"
  end

  create_table "match_exercises", force: :cascade do |t|
    t.string "left_variants", null: false, array: true
    t.string "right_variants", null: false, array: true
    t.integer "answer", null: false, array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "true_or_false_exercises", force: :cascade do |t|
    t.boolean "answer", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.string "access_level", null: false
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["group_id"], name: "index_users_on_group_id"
  end

end
