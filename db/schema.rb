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

ActiveRecord::Schema.define(version: 20150215101444) do

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type", limit: 255
    t.integer  "user_id"
    t.string   "user_type",      limit: 255
    t.text     "modifications"
    t.string   "action",         limit: 255
    t.string   "tag",            limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "audits", ["action"], name: "index_audits_on_action"
  add_index "audits", ["auditable_id", "auditable_type"], name: "auditable_index"
  add_index "audits", ["created_at"], name: "index_audits_on_created_at"
  add_index "audits", ["tag"], name: "index_audits_on_tag"
  add_index "audits", ["user_id", "user_type"], name: "user_index"

  create_table "authorizations", force: :cascade do |t|
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "discounts", force: :cascade do |t|
    t.string   "code",       limit: 255
    t.datetime "begin_date"
    t.datetime "end_date"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "cost"
  end

  create_table "event_users", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "title",               limit: 255
    t.string   "state",               limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.text     "description"
    t.string   "color",               limit: 255
    t.integer  "event_votings_count"
    t.boolean  "show_voting"
  end

  create_table "halls", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "state",            limit: 255
    t.integer  "position_sorting"
  end

  create_table "lectures", force: :cascade do |t|
    t.string   "state",                  limit: 255
    t.string   "presentation",           limit: 255
    t.integer  "listener_votings_count",             default: 0
    t.integer  "lecture_votings_count",              default: 0
    t.integer  "user_id"
    t.string   "title",                  limit: 255
    t.text     "thesises"
    t.integer  "workshop_id"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  create_table "mail_params", force: :cascade do |t|
    t.text     "subject"
    t.text     "begin_of_greetings"
    t.text     "end_of_greetings"
    t.text     "mail_content"
    t.text     "before_link"
    t.text     "after_link"
    t.text     "goodbye"
    t.string   "email",              limit: 255
    t.text     "recipient_name"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "news", force: :cascade do |t|
    t.string   "slug",       limit: 255
    t.string   "title",      limit: 255
    t.text     "body"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "type",           limit: 255
    t.integer  "items_count",                default: 0, null: false
    t.string   "item_size",      limit: 255
    t.string   "payment_state",  limit: 255
    t.string   "transaction_id", limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "item_color",     limit: 255
    t.string   "ticket_type",    limit: 255
    t.integer  "cost"
    t.string   "payment_system", limit: 255
    t.integer  "discounts"
    t.string   "number"
  end

  create_table "pages", force: :cascade do |t|
    t.string   "slug",       limit: 255
    t.string   "title",      limit: 255
    t.text     "body"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255, null: false
    t.text     "data"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "slots", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "hall_id"
    t.datetime "start_time"
    t.datetime "finish_time"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "event_type",  limit: 255
  end

  create_table "topics", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "user_auth_tokens", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "authentication_token", limit: 255
    t.datetime "expired_at"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "user_promo_codes", force: :cascade do |t|
    t.string   "code",       limit: 255
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "user_topics", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                   limit: 255
    t.string   "password_digest",         limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "city",                    limit: 255
    t.string   "company",                 limit: 255
    t.boolean  "show_as_participant"
    t.string   "position",                limit: 255
    t.boolean  "admin"
    t.string   "password",                limit: 255
    t.string   "photo",                   limit: 255
    t.string   "state",                   limit: 255
    t.text     "about"
    t.string   "first_name",              limit: 255
    t.string   "last_name",               limit: 255
    t.string   "role",                    limit: 255
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",      limit: 255
    t.string   "last_sign_in_ip",         limit: 255
    t.text     "carousel_info"
    t.boolean  "in_carousel"
    t.string   "twitter_name",            limit: 255
    t.boolean  "invisible_lector"
    t.string   "timepad_state",           limit: 255
    t.boolean  "not_going_to_conference"
    t.string   "pay_state",               limit: 255
    t.text     "facebook"
    t.text     "vkontakte"
    t.text     "reason_to_give_ticket"
    t.string   "badge_state",             limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "users_lists", force: :cascade do |t|
    t.text     "file"
    t.string   "state",       limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.text     "description"
  end

  create_table "votings", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "type",          limit: 255
    t.integer  "voteable_id"
    t.string   "voteable_type", limit: 255
  end

  create_table "workshops", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "color",      limit: 255
    t.text     "icon"
  end

end
