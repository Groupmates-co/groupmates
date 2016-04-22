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

ActiveRecord::Schema.define(version: 20150718180400) do

  create_table "assets", force: :cascade do |t|
    t.integer  "project_id",            limit: 4
    t.integer  "user_id",               limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uploaded_file_name",    limit: 255
    t.string   "uploaded_content_type", limit: 255
    t.integer  "uploaded_file_size",    limit: 4
    t.datetime "uploaded_updated_at"
    t.integer  "parent_id",             limit: 4,   default: 0, null: false
  end

  add_index "assets", ["project_id"], name: "index_assets_on_project_id", using: :btree
  add_index "assets", ["user_id"], name: "index_assets_on_user_id", using: :btree

  create_table "assets_messages", force: :cascade do |t|
    t.integer "asset_id",   limit: 4
    t.integer "message_id", limit: 4
  end

  add_index "assets_messages", ["asset_id"], name: "index_assets_messages_on_asset_id", using: :btree
  add_index "assets_messages", ["message_id"], name: "index_assets_messages_on_message_id", using: :btree

  create_table "channels", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "is_main",    limit: 1
    t.boolean  "is_private", limit: 1
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "project_id", limit: 4
  end

  create_table "channels_users", id: false, force: :cascade do |t|
    t.integer "channel_id", limit: 4
    t.integer "user_id",    limit: 4
  end

  add_index "channels_users", ["channel_id"], name: "index_channels_users_on_channel_id", using: :btree
  add_index "channels_users", ["user_id"], name: "index_channels_users_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "happening"
    t.integer  "project_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["project_id"], name: "index_events_on_project_id", using: :btree

  create_table "events_users", id: false, force: :cascade do |t|
    t.integer "event_id", limit: 4
    t.integer "user_id",  limit: 4
  end

  add_index "events_users", ["event_id"], name: "index_events_users_on_event_id", using: :btree
  add_index "events_users", ["user_id"], name: "index_events_users_on_user_id", using: :btree

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "message_id", limit: 4
    t.text     "content",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id", limit: 4
  end

  add_index "favorites", ["message_id"], name: "index_favorites_on_message_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "folders", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "parent_id",  limit: 4
    t.integer  "project_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "folders", ["parent_id"], name: "index_folders_on_parent_id", using: :btree
  add_index "folders", ["project_id"], name: "index_folders_on_project_id", using: :btree
  add_index "folders", ["user_id"], name: "index_folders_on_user_id", using: :btree

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "invitations", force: :cascade do |t|
    t.integer  "invited_by_id",    limit: 4
    t.integer  "project_id",       limit: 4
    t.integer  "status",           limit: 4
    t.string   "invitation_token", limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "invited_email",    limit: 255
  end

  add_index "invitations", ["invited_by_id"], name: "index_invitations_on_invited_by_id", using: :btree
  add_index "invitations", ["project_id"], name: "index_invitations_on_project_id", using: :btree

  create_table "ip_addresses", force: :cascade do |t|
    t.string  "address", limit: 255
    t.integer "count",   limit: 4
  end

  create_table "messages", force: :cascade do |t|
    t.text     "content",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "channel_id", limit: 4
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "msg_views", force: :cascade do |t|
    t.integer  "channel_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.integer  "message_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "msg_views", ["channel_id"], name: "index_msg_views_on_channel_id", using: :btree
  add_index "msg_views", ["message_id"], name: "index_msg_views_on_message_id", using: :btree
  add_index "msg_views", ["user_id"], name: "index_msg_views_on_user_id", using: :btree

  create_table "notes", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.integer  "project_id", limit: 4
    t.boolean  "permission", limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["project_id"], name: "index_notes_on_project_id", using: :btree
  add_index "notes", ["user_id"], name: "index_notes_on_user_id", using: :btree

  create_table "preferences", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "project_id", limit: 4
    t.boolean  "on_time",    limit: 1
    t.integer  "from_time",  limit: 4
    t.integer  "to_time",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "preferences", ["project_id"], name: "index_preferences_on_project_id", using: :btree
  add_index "preferences", ["user_id"], name: "index_preferences_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "duration",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",        limit: 255
    t.integer  "creator",     limit: 4
    t.string   "description", limit: 255
  end

  add_index "projects", ["slug"], name: "index_projects_on_slug", using: :btree

  create_table "projects_users", id: false, force: :cascade do |t|
    t.integer "project_id", limit: 4
    t.integer "user_id",    limit: 4
    t.string  "role",       limit: 255
  end

  add_index "projects_users", ["project_id"], name: "index_projects_users_on_project_id", using: :btree
  add_index "projects_users", ["user_id"], name: "index_projects_users_on_user_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating",     limit: 4
    t.text     "feedback",   limit: 65535
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.string   "email",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "referral_code", limit: 255
    t.integer  "referrer_id",   limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",                   limit: 255
    t.string   "last_name",                    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                        limit: 255,   default: "", null: false
    t.string   "encrypted_password",           limit: 255,   default: ""
    t.string   "reset_password_token",         limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",           limit: 255
    t.string   "last_sign_in_ip",              limit: 255
    t.string   "confirmation_token",           limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",            limit: 255
    t.string   "authentication_token",         limit: 255
    t.string   "profile_picture_file_name",    limit: 255
    t.string   "profile_picture_content_type", limit: 255
    t.integer  "profile_picture_file_size",    limit: 4
    t.datetime "profile_picture_updated_at"
    t.integer  "admin",                        limit: 4
    t.integer  "last_project_opened",          limit: 4
    t.datetime "last_project_quit"
    t.boolean  "is_oauth",                     limit: 1
    t.string   "skype",                        limit: 255
    t.text     "bio",                          limit: 65535
    t.text     "phone",                        limit: 65535
    t.datetime "last_notified_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.integer  "versioned_id",   limit: 4
    t.string   "versioned_type", limit: 255
    t.integer  "user_id",        limit: 4
    t.string   "user_type",      limit: 255
    t.string   "user_name",      limit: 255
    t.text     "modifications",  limit: 65535
    t.integer  "number",         limit: 4
    t.integer  "reverted_from",  limit: 4
    t.string   "tag",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "versions", ["created_at"], name: "index_versions_on_created_at", using: :btree
  add_index "versions", ["number"], name: "index_versions_on_number", using: :btree
  add_index "versions", ["tag"], name: "index_versions_on_tag", using: :btree
  add_index "versions", ["user_id", "user_type"], name: "index_versions_on_user_id_and_user_type", using: :btree
  add_index "versions", ["user_name"], name: "index_versions_on_user_name", using: :btree
  add_index "versions", ["versioned_id", "versioned_type"], name: "index_versions_on_versioned_id_and_versioned_type", using: :btree

  add_foreign_key "assets_messages", "assets"
  add_foreign_key "assets_messages", "messages"
end
