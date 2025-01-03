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

ActiveRecord::Schema[8.0].define(version: 2025_01_03_091016) do
  create_table "projects", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "public_id", default: -> { "uuid()" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image", null: false
    t.bigint "user_id", null: false
    t.index ["public_id"], name: "index_projects_on_public_id", unique: true
    t.index ["user_id"], name: "fk_rails_b872a6760a"
  end

  create_table "swots", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "public_id", default: -> { "uuid()" }, null: false
    t.string "strength"
    t.string "weakness"
    t.string "opportunity"
    t.string "threat"
    t.text "analysis"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "project_id", null: false
    t.index ["project_id"], name: "index_swots_on_project_id"
    t.index ["public_id"], name: "index_swots_on_public_id", unique: true
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uid", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  add_foreign_key "projects", "users"
  add_foreign_key "swots", "projects"
end
