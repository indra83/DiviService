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

ActiveRecord::Schema.define(version: 20140126203616) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "books", force: true do |t|
    t.string   "name"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "books", ["course_id"], name: "index_books_on_course_id", using: :btree

  create_table "cdns", force: true do |t|
    t.string   "base_url"
    t.integer  "school_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "pinged_at"
  end

  add_index "cdns", ["school_id"], name: "index_cdns_on_school_id", using: :btree

  create_table "class_rooms", force: true do |t|
    t.string   "standard"
    t.string   "section"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id"
  end

  add_index "class_rooms", ["school_id"], name: "index_class_rooms_on_school_id", using: :btree

  create_table "class_rooms_courses", force: true do |t|
    t.integer "course_id"
    t.integer "class_room_id"
  end

  create_table "class_rooms_users", force: true do |t|
    t.integer  "class_room_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "class_rooms_users", ["class_room_id"], name: "index_class_rooms_users_on_class_room_id", using: :btree
  add_index "class_rooms_users", ["user_id"], name: "index_class_rooms_users_on_user_id", using: :btree

  create_table "courses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instructions", force: true do |t|
    t.integer  "lecture_id"
    t.string   "payload"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "instructions", ["lecture_id"], name: "index_instructions_on_lecture_id", using: :btree

  create_table "lectures", force: true do |t|
    t.integer  "teacher_id"
    t.integer  "class_room_id"
    t.string   "name"
    t.datetime "start_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  add_index "lectures", ["class_room_id"], name: "index_lectures_on_class_room_id", using: :btree
  add_index "lectures", ["teacher_id"], name: "index_lectures_on_teacher_id", using: :btree

  create_table "schools", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location"
  end

  create_table "sync_items", force: true do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.string   "assessment_id"
    t.string   "question_id"
    t.integer  "total_points"
    t.integer  "attempts"
    t.string   "data"
    t.datetime "last_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "correct_attempts"
    t.integer  "wrong_attempts"
    t.integer  "subquestions"
  end

  add_index "sync_items", ["book_id"], name: "index_sync_items_on_book_id", using: :btree
  add_index "sync_items", ["user_id"], name: "index_sync_items_on_user_id", using: :btree

  create_table "updates", force: true do |t|
    t.string   "description"
    t.integer  "book_version"
    t.string   "details"
    t.string   "file"
    t.integer  "book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.string   "strategy"
  end

  add_index "updates", ["book_id"], name: "index_updates_on_book_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "role"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pic"
    t.string   "metadata"
  end

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
