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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140905163331) do

  create_table "comparisons", :force => true do |t|
    t.integer  "winner_id"
    t.integer  "loser_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "froshes", :force => true do |t|
    t.string   "name"
    t.string   "last_name"
    t.integer  "dinner"
    t.integer  "dessert"
    t.string   "image_url"
    t.string   "comments"
    t.string   "anagram"
    t.string   "interest_url"
    t.string   "prelim_rank"
    t.integer  "list"
    t.string   "nickname"
    t.boolean  "male"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "next_id"
    t.boolean  "first"
  end

  add_index "froshes", ["first"], :name => "index_froshes_on_first"
  add_index "froshes", ["next_id"], :name => "index_froshes_on_next_id"

  create_table "votes", :force => true do |t|
    t.integer  "value"
    t.integer  "frosh_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
