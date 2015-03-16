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

ActiveRecord::Schema.define(version: 20150316104556) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body"
    t.string   "resource_id",   limit: 255, null: false
    t.string   "resource_type", limit: 255, null: false
    t.integer  "author_id"
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "attempts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.string   "assessment_id",    limit: 255
    t.string   "question_id",      limit: 255
    t.integer  "total_points"
    t.integer  "attempts"
    t.string   "data",             limit: 255
    t.datetime "last_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "correct_attempts"
    t.integer  "wrong_attempts"
    t.integer  "subquestions"
    t.integer  "course_id"
    t.datetime "solved_at"
  end

  add_index "attempts", ["book_id"], name: "index_attempts_on_book_id", using: :btree
  add_index "attempts", ["user_id"], name: "index_attempts_on_user_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "live_updates_start"
    t.integer  "staging_updates_start"
    t.integer  "testing_updates_start"
  end

  add_index "books", ["course_id"], name: "index_books_on_course_id", using: :btree

  create_table "cdns", force: :cascade do |t|
    t.string   "base_url",   limit: 255
    t.integer  "school_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "pinged_at"
    t.json     "metadata"
  end

  add_index "cdns", ["school_id"], name: "index_cdns_on_school_id", using: :btree

  create_table "class_rooms", force: :cascade do |t|
    t.string   "standard",             limit: 255
    t.string   "section",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id"
    t.string   "allowed_app_packages",             array: true
  end

  add_index "class_rooms", ["school_id"], name: "index_class_rooms_on_school_id", using: :btree

  create_table "class_rooms_courses", force: :cascade do |t|
    t.integer "course_id"
    t.integer "class_room_id"
  end

  create_table "class_rooms_users", force: :cascade do |t|
    t.integer  "class_room_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "class_rooms_users", ["class_room_id"], name: "index_class_rooms_users_on_class_room_id", using: :btree
  add_index "class_rooms_users", ["user_id"], name: "index_class_rooms_users_on_user_id", using: :btree

  create_table "commands", force: :cascade do |t|
    t.integer  "class_room_id"
    t.integer  "teacher_id"
    t.integer  "course_id"
    t.integer  "book_id"
    t.string   "item_code",     limit: 255
    t.string   "item_category", limit: 255
    t.string   "category",      limit: 255
    t.string   "status",        limit: 255
    t.json     "data"
    t.datetime "applied_at"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "setid",         limit: 255
    t.integer  "student_id"
  end

  add_index "commands", ["book_id"], name: "index_commands_on_book_id", using: :btree
  add_index "commands", ["class_room_id"], name: "index_commands_on_class_room_id", using: :btree
  add_index "commands", ["course_id"], name: "index_commands_on_course_id", using: :btree
  add_index "commands", ["student_id"], name: "index_commands_on_student_id", using: :btree
  add_index "commands", ["teacher_id"], name: "index_commands_on_teacher_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instructions", force: :cascade do |t|
    t.integer  "lecture_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json     "payload"
  end

  add_index "instructions", ["lecture_id"], name: "index_instructions_on_lecture_id", using: :btree

  create_table "lectures", force: :cascade do |t|
    t.integer  "teacher_id"
    t.integer  "class_room_id"
    t.string   "name",          limit: 255
    t.datetime "start_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",        limit: 255
    t.datetime "ends_at"
  end

  add_index "lectures", ["class_room_id"], name: "index_lectures_on_class_room_id", using: :btree
  add_index "lectures", ["teacher_id"], name: "index_lectures_on_teacher_id", using: :btree

  create_table "schools", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location",   limit: 255
  end

  create_table "tablets", force: :cascade do |t|
    t.string   "device_id",     limit: 255
    t.string   "device_tag",    limit: 255
    t.string   "token",         limit: 255
    t.integer  "user_id"
    t.json     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "battery_level"
    t.text     "metadata"
  end

  add_index "tablets", ["device_id"], name: "index_tablets_on_device_id", unique: true, using: :btree
  add_index "tablets", ["user_id"], name: "index_tablets_on_user_id", using: :btree

  create_table "updates", force: :cascade do |t|
    t.string   "description",       limit: 255
    t.integer  "book_version"
    t.string   "details",           limit: 255
    t.string   "file",              limit: 255
    t.integer  "book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",            limit: 255
    t.string   "strategy",          limit: 255
    t.integer  "book_from_version"
    t.boolean  "copy"
  end

  add_index "updates", ["book_id"], name: "index_updates_on_book_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "password_digest",  limit: 255
    t.string   "role",             limit: 255
    t.string   "token",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pic",              limit: 255
    t.string   "phone",            limit: 255
    t.string   "email",            limit: 255
    t.string   "parent_phone",     limit: 255
    t.string   "parent_email",     limit: 255
    t.datetime "report_starts_at"
    t.json     "pic_crop_factor"
    t.json     "metadata"
  end

  add_index "users", ["token"], name: "index_users_on_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 255, null: false
    t.integer  "item_id",                null: false
    t.string   "event",      limit: 255, null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
