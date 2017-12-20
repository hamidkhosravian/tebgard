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

ActiveRecord::Schema.define(version: 20171220114726) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.bigint "office_id"
    t.bigint "profile_id"
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "uuid"
    t.index ["office_id"], name: "index_appointments_on_office_id"
    t.index ["profile_id"], name: "index_appointments_on_profile_id"
  end

  create_table "articles", force: :cascade do |t|
    t.bigint "wall_id"
    t.text "body"
    t.string "uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["wall_id"], name: "index_articles_on_wall_id"
  end

  create_table "auth_tokens", force: :cascade do |t|
    t.string "token"
    t.string "refresh_token"
    t.datetime "token_expires_at"
    t.datetime "refresh_token_expires_at"
    t.string "tokenable_type"
    t.bigint "tokenable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tokenable_type", "tokenable_id"], name: "index_auth_tokens_on_tokenable_type_and_tokenable_id"
  end

  create_table "availables", force: :cascade do |t|
    t.boolean "status", default: false
    t.date "date"
    t.time "start_time"
    t.time "end_time"
    t.string "availability_type"
    t.bigint "availability_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.index ["availability_type", "availability_id"], name: "index_availables_on_availability_type_and_availability_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "commentable_type"
    t.bigint "commentable_id"
    t.bigint "wall_id"
    t.string "body"
    t.string "uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["wall_id"], name: "index_comments_on_wall_id"
  end

  create_table "devices", force: :cascade do |t|
    t.string "device_name", default: "", null: false
    t.integer "device_os"
    t.inet "device_last_ip"
    t.inet "device_current_ip"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_name"], name: "index_devices_on_device_name"
    t.index ["user_id"], name: "index_devices_on_user_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "documentable_type"
    t.bigint "documentable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "attachment_file_name"
    t.string "attachment_content_type"
    t.integer "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.index ["documentable_type", "documentable_id"], name: "index_documents_on_documentable_type_and_documentable_id"
  end

  create_table "identities", force: :cascade do |t|
    t.bigint "user_id"
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "multimedia", force: :cascade do |t|
    t.string "multimediable_type"
    t.bigint "multimediable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "attachment_file_name"
    t.string "attachment_content_type"
    t.integer "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.index ["multimediable_type", "multimediable_id"], name: "index_multimedia_on_multimediable_type_and_multimediable_id"
  end

  create_table "offices", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.string "office_phone_number"
    t.string "address"
    t.bigint "wall_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.string "uuid"
    t.integer "appointment_duration", default: 1800
    t.boolean "holiday_activation", default: false
    t.string "location_address"
    t.string "time_zone"
    t.index ["wall_id"], name: "index_offices_on_wall_id"
  end

  create_table "open_days", force: :cascade do |t|
    t.bigint "office_id"
    t.integer "day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["office_id"], name: "index_open_days_on_office_id"
  end

  create_table "open_hours", force: :cascade do |t|
    t.time "open_time"
    t.time "close_time"
    t.bigint "open_day_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["open_day_id"], name: "index_open_hours_on_open_day_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.string "imageable_type"
    t.bigint "imageable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.index ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable_type_and_imageable_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "wall_id"
    t.string "body"
    t.string "uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["wall_id"], name: "index_posts_on_wall_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "first_name"
    t.string "last_name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone"
    t.date "birthdate"
    t.string "email"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "username"
    t.integer "gender"
    t.integer "role"
    t.string "uuid"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
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
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.string "votable_type"
    t.bigint "votable_id"
    t.string "voter_type"
    t.bigint "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable_type_and_votable_id"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
    t.index ["voter_type", "voter_id"], name: "index_votes_on_voter_type_and_voter_id"
  end

  create_table "walls", force: :cascade do |t|
    t.boolean "active", default: false
    t.string "doctor_code", null: false
    t.string "description"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.index ["profile_id"], name: "index_walls_on_profile_id"
  end

  add_foreign_key "appointments", "offices"
  add_foreign_key "appointments", "profiles"
  add_foreign_key "articles", "walls"
  add_foreign_key "comments", "walls"
  add_foreign_key "devices", "users"
  add_foreign_key "identities", "users"
  add_foreign_key "offices", "walls"
  add_foreign_key "open_days", "offices"
  add_foreign_key "open_hours", "open_days"
  add_foreign_key "posts", "walls"
  add_foreign_key "walls", "profiles"
end
