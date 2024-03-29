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

ActiveRecord::Schema[7.0].define(version: 2022_08_23_161708) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "answer_likes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "answer_id", null: false
    t.integer "user_id", null: false
    t.index ["answer_id"], name: "index_answer_likes_on_answer_id"
    t.index ["user_id"], name: "index_answer_likes_on_user_id"
  end

  create_table "answers", force: :cascade do |t|
    t.text "text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "question_id", null: false
    t.integer "user_id"
    t.boolean "anonymous", default: false
    t.integer "answer_likes_count"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "teachers_subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_enrollments_on_student_id"
    t.index ["teachers_subject_id"], name: "index_enrollments_on_teachers_subject_id"
  end

  create_table "question_likes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "question_id", null: false
    t.integer "user_id"
    t.index ["question_id"], name: "index_question_likes_on_question_id"
    t.index ["user_id"], name: "index_question_likes_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "title", null: false
    t.text "details"
    t.integer "importance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "enrollment_id", null: false
    t.boolean "anonymous", default: false
    t.index ["enrollment_id"], name: "index_questions_on_enrollment_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "subject_name", null: false
    t.string "activity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teachers_subjects", force: :cascade do |t|
    t.integer "teacher_id", null: false
    t.integer "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_teachers_subjects_on_subject_id"
    t.index ["teacher_id"], name: "index_teachers_subjects_on_teacher_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "phone", null: false
    t.string "role", null: false
    t.boolean "activated", default: false, null: false
    t.string "group", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answer_likes", "answers"
  add_foreign_key "answer_likes", "users"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "enrollments", "teachers_subjects"
  add_foreign_key "enrollments", "users", column: "student_id"
  add_foreign_key "question_likes", "questions"
  add_foreign_key "question_likes", "users"
  add_foreign_key "questions", "enrollments"
  add_foreign_key "teachers_subjects", "subjects"
  add_foreign_key "teachers_subjects", "users", column: "teacher_id"
end
