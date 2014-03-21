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

ActiveRecord::Schema.define(version: 20140320221446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "analyzed_posts", force: true do |t|
    t.integer  "school_id"
    t.string   "overall_sentiment"
    t.string   "geofeedia_school_id"
    t.string   "original_publish_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "keywords", force: true do |t|
    t.integer  "analyzed_post_id"
    t.string   "text"
    t.string   "sentiment"
    t.float    "confidence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "original_posts", force: true do |t|
    t.text     "text"
    t.integer  "school_id"
    t.string   "geofeedia_school_id"
    t.string   "original_publish_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", force: true do |t|
    t.integer  "topic_id"
    t.integer  "school_id"
    t.integer  "positive_post_count", default: 0
    t.integer  "negative_post_count", default: 0
    t.integer  "neutral_post_count",  default: 0
    t.integer  "mixed_post_count",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reference_words", force: true do |t|
    t.string   "name"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "school_word_counts", force: true do |t|
    t.integer  "school_id"
    t.integer  "reference_word_id"
    t.integer  "word_count",          default: 0
    t.integer  "positive_word_count", default: 0
    t.integer  "negative_word_count", default: 0
    t.integer  "neutral_word_count",  default: 0
    t.integer  "mixed_word_count",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", force: true do |t|
    t.string   "name"
    t.string   "most_recent_post_time"
    t.integer  "post_count",            default: 0
    t.integer  "positive_post_count",   default: 0
    t.integer  "negative_post_count",   default: 0
    t.integer  "neutral_post_count",    default: 0
    t.integer  "mixed_post_count",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
