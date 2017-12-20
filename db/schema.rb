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

ActiveRecord::Schema.define(version: 20171219140836) do

  create_table "item_services", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "music_service_id"
    t.integer  "list_item_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["list_item_id"], name: "index_item_services_on_list_item_id", using: :btree
    t.index ["music_service_id"], name: "index_item_services_on_music_service_id", using: :btree
  end

  create_table "list_contents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "list_id"
    t.integer  "list_item_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["list_id"], name: "index_list_contents_on_list_id", using: :btree
    t.index ["list_item_id"], name: "index_list_contents_on_list_item_id", using: :btree
  end

  create_table "list_favorites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "list_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_list_favorites_on_list_id", using: :btree
    t.index ["user_id"], name: "index_list_favorites_on_user_id", using: :btree
  end

  create_table "list_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "artist"
    t.string   "song"
    t.integer  "favorite"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "description"
    t.integer  "price"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["user_id"], name: "index_lists_on_user_id", using: :btree
  end

  create_table "music_services", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.text     "url",        limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "purchases", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.date     "order_date"
    t.integer  "user_id"
    t.integer  "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_purchases_on_list_id", using: :btree
    t.index ["user_id"], name: "index_purchases_on_user_id", using: :btree
  end

  create_table "user_favorites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "favoriter_id"
    t.integer  "favorited_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["favorited_id"], name: "index_user_favorites_on_favorited_id", using: :btree
    t.index ["favoriter_id", "favorited_id"], name: "index_user_favorites_on_favoriter_id_and_favorited_id", unique: true, using: :btree
    t.index ["favoriter_id"], name: "index_user_favorites_on_favoriter_id", using: :btree
  end

  create_table "user_profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.text     "description",         limit: 65535
    t.text     "insta_url",           limit: 65535
    t.text     "tw_url",              limit: 65535
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["user_id"], name: "index_user_profiles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "item_services", "list_items"
  add_foreign_key "item_services", "music_services"
  add_foreign_key "list_contents", "list_items"
  add_foreign_key "list_contents", "lists"
  add_foreign_key "list_favorites", "lists"
  add_foreign_key "list_favorites", "users"
  add_foreign_key "lists", "users"
  add_foreign_key "purchases", "lists"
  add_foreign_key "purchases", "users"
  add_foreign_key "user_profiles", "users"
end
