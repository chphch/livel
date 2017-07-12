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

ActiveRecord::Schema.define(version: 20170712063250) do

  create_table "artists", force: :cascade do |t|
    t.integer "curation_id"
    t.integer "artist_id"
    t.string "name"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_artists_on_artist_id"
    t.index ["curation_id"], name: "index_artists_on_curation_id"
  end

  create_table "connect_urls", force: :cascade do |t|
    t.integer "user_id"
    t.integer "feed_id"
    t.string "video_url"
    t.text "describe"
    t.boolean "is_confirmed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feed_id"], name: "index_connect_urls_on_feed_id"
    t.index ["user_id"], name: "index_connect_urls_on_user_id"
  end

  create_table "curation_artists", force: :cascade do |t|
    t.integer "curation_id"
    t.integer "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_curation_artists_on_artist_id"
    t.index ["curation_id"], name: "index_curation_artists_on_curation_id"
  end

  create_table "curation_comments", force: :cascade do |t|
    t.integer "curation_id"
    t.integer "user_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["curation_id"], name: "index_curation_comments_on_curation_id"
    t.index ["user_id"], name: "index_curation_comments_on_user_id"
  end

  create_table "curation_likes", force: :cascade do |t|
    t.integer "curation_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["curation_id"], name: "index_curation_likes_on_curation_id"
    t.index ["user_id"], name: "index_curation_likes_on_user_id"
  end

  create_table "curations", force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.text "content"
    t.string "youtube_id"
    t.integer "count_share"
    t.integer "count_view"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_curations_on_user_id"
  end

  create_table "feed_artists", force: :cascade do |t|
    t.integer "feed_id"
    t.integer "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_feed_artists_on_artist_id"
    t.index ["feed_id"], name: "index_feed_artists_on_feed_id"
  end

  create_table "feed_comments", force: :cascade do |t|
    t.integer "feed_id"
    t.integer "user_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feed_id"], name: "index_feed_comments_on_feed_id"
    t.index ["user_id"], name: "index_feed_comments_on_user_id"
  end

  create_table "feed_likes", force: :cascade do |t|
    t.integer "feed_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feed_id"], name: "index_feed_likes_on_feed_id"
    t.index ["user_id"], name: "index_feed_likes_on_user_id"
  end

  create_table "feeds", force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.string "youtube_id"
    t.integer "count_view"
    t.integer "count_share"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_feeds_on_user_id"
  end

  create_table "recent_keywords", force: :cascade do |t|
    t.integer "user_id"
    t.string "keyword"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_recent_keywords_on_user_id"
  end

  create_table "upcoming_artists", force: :cascade do |t|
    t.integer "upcoming_id"
    t.integer "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_upcoming_artists_on_artist_id"
    t.index ["upcoming_id"], name: "index_upcoming_artists_on_upcoming_id"
  end

  create_table "upcoming_comments", force: :cascade do |t|
    t.integer "upcoming_id"
    t.integer "user_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["upcoming_id"], name: "index_upcoming_comments_on_upcoming_id"
    t.index ["user_id"], name: "index_upcoming_comments_on_user_id"
  end

  create_table "upcoming_likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "upcoming_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["upcoming_id"], name: "index_upcoming_likes_on_upcoming_id"
    t.index ["user_id"], name: "index_upcoming_likes_on_user_id"
  end

  create_table "upcomings", force: :cascade do |t|
    t.string "title"
    t.string "place"
    t.string "main_youtube_id"
    t.date "start_date"
    t.date "end_date"
    t.string "ticket_url"
    t.integer "count_view"
    t.integer "count_share"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "provider"
    t.string "uid"
    t.string "nickname"
    t.string "profile_img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
