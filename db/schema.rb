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

ActiveRecord::Schema.define(version: 20150508082351) do

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "cart_id",    limit: 4
    t.integer  "qty",        limit: 4, default: 1
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "order_id",   limit: 4
    t.integer  "packet_id",  limit: 4
    t.integer  "subtotal",   limit: 4,             null: false
  end

  add_index "line_items", ["cart_id"], name: "index_line_items_on_cart_id", using: :btree
  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "phone",      limit: 255
    t.string   "address",    limit: 255
    t.string   "email",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "status",     limit: 255
  end

  create_table "packets", force: :cascade do |t|
    t.string   "title",      limit: 255,   null: false
    t.text     "content",    limit: 65535
    t.integer  "product_id", limit: 4,     null: false
    t.integer  "price",      limit: 4,     null: false
    t.string   "video",      limit: 255,   null: false
    t.text     "ingredient", limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "packets", ["product_id"], name: "index_packets_on_product_id", using: :btree

  create_table "pictures", force: :cascade do |t|
    t.text     "title",      limit: 65535, null: false
    t.string   "image_url",  limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",                   limit: 255,               null: false
    t.integer  "price",                  limit: 4,                 null: false
    t.text     "description",            limit: 65535
    t.integer  "in_stock_qty",           limit: 4,     default: 0, null: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "image_url",              limit: 255
    t.string   "image_url_file_name",    limit: 255
    t.string   "image_url_content_type", limit: 255
    t.integer  "image_url_file_size",    limit: 4
    t.datetime "image_url_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token",   limit: 255
    t.string   "fb_uid",                 limit: 255
    t.string   "fb_access_token",        limit: 255
    t.datetime "fb_expires_at"
    t.string   "role",                   limit: 255
    t.string   "name",                   limit: 255
    t.string   "image",                  limit: 255
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["fb_uid"], name: "index_users_on_fb_uid", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
