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

ActiveRecord::Schema.define(version: 20170421145714) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "memes", force: :cascade do |t|
    t.string   "name",           null: false
    t.string   "image_url",      null: false
    t.string   "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "contributor_id", null: false
  end

  create_table "review_votes", force: :cascade do |t|
    t.integer  "review_id"
    t.boolean  "upvote",     default: false
    t.boolean  "downvote",   default: false
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["review_id"], name: "index_review_votes_on_review_id", using: :btree
    t.index ["user_id"], name: "index_review_votes_on_user_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating",     null: false
    t.string   "body"
    t.integer  "meme_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meme_id"], name: "index_reviews_on_meme_id", using: :btree
    t.index ["user_id"], name: "index_reviews_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",                                 null: false
    t.string   "last_name",                                  null: false
    t.string   "username",                                   null: false
    t.string   "avatar_url"
    t.boolean  "admin",                  default: false
    t.text     "bio",                    default: "No bio."
    t.string   "email",                  default: "",        null: false
    t.string   "encrypted_password",     default: "",        null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
